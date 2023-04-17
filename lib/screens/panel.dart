import 'package:emg_app/models/patient.dart';
import 'package:emg_app/widgets/graph.dart';
import 'package:emg_app/widgets/history.dart';
import 'package:emg_app/widgets/patient.dart';
import 'package:emg_app/widgets/samples.dart';
import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PatientSection(
                      patient: Patient('', 0, false),
                    ),
                    Spacer(),
                    Graph(),
                    Spacer(),
                    Samples(),
                  ],
                ),
                const History(),
              ],
            ),
          ),
          Positioned(
            bottom: 18,
            right: 18,
            child: Image.asset(
              'assets/images/emg_logo.png',
              height: 32,
            ),
          ),
        ],
      ),
    );
  }
}
