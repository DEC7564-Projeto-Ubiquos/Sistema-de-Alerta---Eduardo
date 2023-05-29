import 'package:emg_app/widgets/voltage_sample_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final List<VoltageSample> sampleData = [
    VoltageSample(0, 100),
    VoltageSample(1, 200),
    VoltageSample(2, 300),
    VoltageSample(3, 400),
    VoltageSample(4, 200),
    VoltageSample(5, 300),
    VoltageSample(6, 100),
    VoltageSample(7, 200),
    VoltageSample(8, 300),
    VoltageSample(9, 100),
    VoltageSample(10, 200),
    VoltageSample(11, 300),
    VoltageSample(12, 100),
    VoltageSample(13, 200),
    VoltageSample(14, 300),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 16, 0),
      child: Row(
        children: [
          SizedBox(
            height: 300,
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 98, 0, 238),
                    ),
                    child: const Icon(
                      Icons.question_mark,
                      size: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 98, 0, 238),
                    ),
                    child: const Icon(
                      Icons.question_mark,
                      size: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 98, 0, 238),
                    ),
                    child: const Icon(
                      Icons.question_mark,
                      size: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 98, 0, 238),
                    ),
                    child: const Icon(
                      Icons.question_mark,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            width: (MediaQuery.of(context).size.width * 0.75) - 140,
            child: VoltageSampleChart(data: sampleData),
          ),
        ],
      ),
    );
  }
}
