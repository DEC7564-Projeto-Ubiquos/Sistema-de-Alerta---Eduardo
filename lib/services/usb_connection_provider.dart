import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:emg_app/models/sample.dart';
import 'package:emg_app/services/isar_database/isar_database.dart';
import 'package:emg_app/services/isar_database/isar_database_prod.dart';
import 'package:emg_app/widgets/voltage_sample_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class UsbConnectionProvider with ChangeNotifier {
  late Isar _isar;

  final IsarDatabase _db = IsarDatabaseProd();

  List<String> _availablePorts = [];

  String? _selectedPort;

  SerialPort? _port;

  SerialPortReader? serialPortReader;

  List<String> get availablePorts => _availablePorts;

  String? get selectedPort => _selectedPort;

  StreamSubscription<List<int>>? subscription;

  bool _isReading = false;

  bool get isReading => _isReading;

  int _time = 0;

  Stream<Uint8List>? serialPortStream;

  StreamController<String> streamController = StreamController<String>();

  Future<void> init() async {
    _isar = await _db.openIsar();
    notifyListeners();
  }

  UsbConnectionProvider() {
    getAvailablePorts();
  }

  getAvailablePorts() {
    _availablePorts = SerialPort.availablePorts;
    notifyListeners();
  }

  void setSelectedPort(String port) {
    _selectedPort = port;
    notifyListeners();
  }

  void showSelectPortDialog(BuildContext context) async {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    getAvailablePorts();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Selecione o Sensor',
            style: textTheme.titleLarge,
          ),
          content: SizedBox(
            height: 300.0,
            width: 300.0,
            child: ListView(
              children: _availablePorts.map((port) {
                return ListTile(
                  leading: const Icon(Icons.usb),
                  title: Text(port),
                  onTap: () {
                    _connectTo(port);
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Future<void> _connectTo(String portName) async {
    try {
      final availablePorts = SerialPort.availablePorts;

      if (!availablePorts.contains(portName)) {
        throw Exception('A porta $portName não está disponível');
      }

      _port = SerialPort(portName);

      if (!_port!.open(mode: SerialPortMode.readWrite)) {
        if (kDebugMode) {
          print("error opening serial port: ${SerialPort.lastError}");
        }
      } else {
        final config = SerialPortConfig()
          ..baudRate = 115200
          ..bits = 8
          ..stopBits = 1
          ..parity = SerialPortParity.none
          ..setFlowControl(SerialPortFlowControl.none);

        _port!.config = config;
        if (kDebugMode) {
          print("está aberto: ${_port!.isOpen}");
        }
      }
      serialPortReader = SerialPortReader(_port!);
      serialPortStream = serialPortReader!.stream.asBroadcastStream();

      _selectedPort = portName;

      subscription?.cancel();

      notifyListeners();
    } on Exception catch (e) {
      if (kDebugMode) {
        print(
            "can not write into serial port: ${SerialPort.lastError}, ${e.toString()}");
      }
    }
  }

  Future<void> measureAndStore(BuildContext context, Sample sample) async {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    if (_port == null || serialPortReader == null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Sensor não Selecionado',
              style: textTheme.titleLarge,
            ),
            content: Text(
              'Selecione um sensor antes de fazer medições.',
              style: textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                child: Text(
                  'Fechar',
                  style: textTheme.bodyLarge,
                ),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          );
        },
      );
      return;
    }

    List<int> sensorData = [];

    _isReading = true;
    notifyListeners();

    var commandStr = "medir,${_time.toString()}\n";
    var commandBytes = Uint8List.fromList(commandStr.codeUnits);

    _port!.write(commandBytes);

    _port!.flush();

    subscription = serialPortStream!.listen((value) async {
      if (kDebugMode) {
        print('VALUE: $value');
      }
      String decodedValue = utf8.decode(value);
      if (kDebugMode) {
        print('UTF8:$decodedValue');
      }

      List<String> lines = decodedValue.split('\n');

      for (var line in lines) {
        line = line.trim();
        int? receivedValue;
        try {
          if (line.isNotEmpty) {
            receivedValue = int.parse(line);
          }
        } catch (e) {
          if (kDebugMode) {
            print("Error in string to int conversion: $e");
            print("Received string: '$line'");
          }
        }
        if (receivedValue != null) {
          sensorData.add(receivedValue);
        }
      }
    });

    Timer(Duration(seconds: _time), () {
      if (_isReading) {
        subscription?.cancel();
        _isReading = false;
        subscription?.cancel();
        processSensorData(sensorData, sample);
        notifyListeners();
      }
    });
  }

  void processSensorData(List<int> sensorData, Sample sample) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/${sample.examId}_${sample.id}.csv');
    await file.writeAsString(sensorData.map((e) => e.toString()).join('\n'));

    sample.filePath = file.path;
    //sample.value = ?? value é double

    _db.putSample(_isar, sample).then((_) {
      notifyListeners();
    });
  }

  Future<List<VoltageSample>> loadCSVData(String path) async {
    final file = File(path);
    if (!file.existsSync()) {
      throw Exception('Arquivo não encontrado.');
    }

    final lines = await file.readAsLines();
    final List<VoltageSample> tempChartData = [];
    for (int i = 0; i < lines.length; i++) {
      try {
        double sample = i.toDouble();
        double voltage = double.parse(lines[i]);
        tempChartData.add(VoltageSample(sample, voltage));
      } catch (e) {
        if (kDebugMode) {
          print('Erro: $e');
        }
      }
    }
    return tempChartData;
  }

  Future<void> requestCalibration(BuildContext context) async {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    if (_port == null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Sensor não Selecionado',
              style: textTheme.titleLarge,
            ),
            content: Text(
              'Selecione um sensor antes de fazer uma calibração.',
              style: textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                child: Text(
                  'Fechar',
                  style: textTheme.bodyLarge,
                ),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          );
        },
      );
      return;
    }

    var commandStr = "calibrar,${_time.toString()}\n";
    var commandBytes = Uint8List.fromList(commandStr.codeUnits);

    _port!.write(commandBytes);

    _port!.flush();

    if (streamController.isClosed) {
      streamController = StreamController<String>();
    }

    subscription = serialPortStream!.listen((value) async {
      if (kDebugMode) {
        print('VALUE: $value');
      }
      String decodedValue = utf8.decode(value).trim();
      if (kDebugMode) {
        print('UTF8:$decodedValue');
      }
      streamController.add(decodedValue);
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StreamBuilder<String>(
            stream: streamController.stream,
            builder: (context, snapshot) {
              if (kDebugMode) {
                print('SNAPSHOT DATA:${snapshot.data}');
              }

              if (snapshot.data == 'finalizado') {
                streamController.close();
              }
              return AlertDialog(
                title: Text(
                  'Calibrando Sensor',
                  style: textTheme.titleLarge,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        snapshot.data == 'configurando'
                            ? 'Configurando. Aguarde...'
                            : snapshot.data == 'iniciado'
                                ? 'Fique parado! Calibrando sensor.'
                                : snapshot.data == 'finalizado'
                                    ? 'Pronto!'
                                    : '',
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  snapshot.data == 'finalizado'
                      ? TextButton(
                          child: Text(
                            'Fechar',
                            style: textTheme.bodyLarge,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            streamController.close();
                            subscription?.cancel();
                          },
                        )
                      : snapshot.data != 'finalizado' &&
                              snapshot.data != 'iniciado' &&
                              !snapshot.data.toString().contains('configurando')
                          ? TextButton(
                              child: Text(
                                'Fechar',
                                style: textTheme.bodyLarge,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                streamController.close();
                                subscription?.cancel();
                              },
                            )
                          : Container(),
                ],
              );
            });
      },
    );
  }

  Future<void> setTime(BuildContext context) async {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    final timeController = TextEditingController(text: _time.toString());

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Tempo de Medição',
            style: textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Informe um tempo em segundos.',
                style: textTheme.bodyLarge,
              ),
              TextField(
                controller: timeController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'Fechar',
                style: textTheme.bodyLarge,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                'Salvar',
                style: textTheme.bodyLarge,
              ),
              onPressed: () {
                _time = int.parse(timeController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _port?.close();
    super.dispose();
  }
}
