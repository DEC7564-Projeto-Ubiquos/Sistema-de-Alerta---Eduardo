import 'package:emg_app/models/patient.dart';
import 'package:flutter/material.dart';

class PatientSection extends StatelessWidget {
  final Patient patient;
  const PatientSection({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Paciente');
  }
}
