import 'dart:async';
import 'dart:io';

import 'package:emg_app/models/sample.dart';
import 'package:emg_app/services/isar_database/isar_database.dart';
import 'package:emg_app/services/isar_database/isar_database_prod.dart';
import 'package:emg_app/widgets/voltage_sample_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class UsbConnectionProvider with ChangeNotifier {
  late Isar _isar;
  final IsarDatabase _db = IsarDatabaseProd();
  List<String> _availablePorts = [];
  String? _selectedPort;
  SerialPort? _port;

  List<String> get availablePorts => _availablePorts;
  String? get selectedPort => _selectedPort;

  StreamSubscription<List<int>>? subscription;

  bool _isReading = false;

  bool get isReading => _isReading;

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

      final port = SerialPort(portName);
      final config = SerialPortConfig();
      config.baudRate = 115200;
      config.bits = 8;
      config.parity = 0;
      config.stopBits = 1;
      port.config = config;

      if (!port.openReadWrite()) {
        if (kDebugMode) {
          print("error opening serial port: ${SerialPort.lastError}");
        }
      } else {
        if (kDebugMode) {
          print("está aberto: ${port.isOpen}");
        }
      }
      _port = port;
      _selectedPort = portName;
      notifyListeners();
    } on Exception catch (e) {
      if (kDebugMode) {
        print(
            "can not write into serial port: ${SerialPort.lastError}, ${e.toString()}");
      }
    }
  }

  Future<void> measureAndStore(BuildContext context, Sample sample) async {
    if (_port == null) {
      final textTheme = Theme.of(context)
          .textTheme
          .apply(displayColor: Theme.of(context).colorScheme.onSurface);

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

    SerialPortReader serialPortReader = SerialPortReader(_port!);

    List<int> sensorData = [];

    _isReading = true;
    notifyListeners();

    subscription = serialPortReader.stream.listen((value) {
      String receivedString = String.fromCharCodes(value);
      List<String> lines = receivedString.split('\n');
      for (var line in lines) {
        line = line.trim(); // Remove caracteres indesejados como '\r'
        int? receivedValue;
        try {
          if (line.isNotEmpty) {
            receivedValue = int.parse(line);
          }
        } catch (e) {
          print("Erro na conversão de string para int: $e");
          print("String recebida: '$line'");
        }
        if (receivedValue != null) {
          sensorData.add(receivedValue);
        }
      }
    });

    await Future.delayed(const Duration(seconds: 5));

    _isReading = false;
    notifyListeners();

    subscription?.cancel();

    serialPortReader.close();

    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/${sample.examId}_${sample.id}.csv');
    await file.writeAsString(sensorData.map((e) => e.toString()).join('\n'));

    sample.filePath = file.path;

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

  Future<void> requestCalibration(BuildContext context, int seconds) async {
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

    var commandStr = "calibrar,$seconds\n";
    var commandBytes = Uint8List.fromList(commandStr.codeUnits);

    _port!.write(commandBytes);

    SerialPortReader serialPortReader = SerialPortReader(_port!);

    Stream<String> calibrationStream = serialPortReader.stream.map((value) {
      print(value);
      return String.fromCharCodes(value).trim();
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StreamBuilder<String>(
            stream: calibrationStream,
            builder: (context, snapshot) {
              if (kDebugMode) {
                print('SNAPSHOT DATA:${snapshot.data}');
              }

              if (snapshot.data == 'finalizado') {
                serialPortReader.close();
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
                        snapshot.data.toString().contains('configurando')
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
                            serialPortReader.close();
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
                                serialPortReader.close();
                              },
                            )
                          : Container(),
                ],
              );
            });
      },
    );
  }

  @override
  void dispose() {
    _port?.close();
    super.dispose();
  }
}
