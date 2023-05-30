import 'package:emg_app/services/patient_provider.dart';
import 'package:emg_app/widgets/voltage_sample_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final List<VoltageSample> sampleData = [
    VoltageSample(0, 0),
    VoltageSample(200, 500),
    VoltageSample(400, 2200),
    VoltageSample(600, 2200),
    VoltageSample(800, 500),
    VoltageSample(1000, 0),
  ];

  late PatientProvider patientProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    patientProvider = Provider.of<PatientProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 16, 0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 300,
              maxHeight: viewportConstraints.maxHeight,
            ),
            child: SizedBox(
              width: (MediaQuery.of(context).size.width * 0.75) - 64,
              child: VoltageSampleChart(
                data: sampleData,
                color: const Color.fromARGB(255, 255, 69, 0),
              ),
            ),
          );
        },
      ),
    );
  }
}
