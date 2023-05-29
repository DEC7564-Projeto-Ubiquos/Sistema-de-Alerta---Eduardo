import 'package:emg_app/models/patient.dart';
import 'package:emg_app/widgets/graph.dart';
import 'package:emg_app/widgets/history.dart';
import 'package:emg_app/widgets/patient.dart';
import 'package:emg_app/widgets/samples.dart';
import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final Patient patient;
  const Panel({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        PatientSection(
                          patient:
                              Patient(patient.identificador, patient.idade),
                        ),
                        const SizedBox(height: 10),
                        const Graph(),
                        const SizedBox(height: 10),
                        const Samples(),
                      ],
                    ),
                  ),
                  const History(),
                ],
              ),
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
