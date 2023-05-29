import 'package:emg_app/models/patient.dart';
import 'package:emg_app/services/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientSection extends StatelessWidget {
  final Patient patient;
  const PatientSection({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Paciente', style: textTheme.titleMedium),
              Text(getPatientName(), style: textTheme.titleLarge),
              Text(getPatientAge(), style: textTheme.titleSmall),
            ],
          ),
        ),
        getActionButtons(context),
      ],
    );
  }

  bool hasPatient() {
    return patient.identificador.isNotEmpty;
  }

  getActionButtons(BuildContext context) {
    if (hasPatient()) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: () {
                Provider.of<PatientProvider>(context, listen: false)
                    .clearSelectedPatient();
                Provider.of<PatientProvider>(context, listen: false)
                    .checkForSelectedPatient(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 98, 0, 238),
              ),
              child: const Icon(
                Icons.close,
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
                Icons.save,
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
                Icons.picture_as_pdf,
                size: 16,
              ),
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilledButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 98, 0, 238),
          ),
          child: const Icon(
            Icons.add,
            size: 16,
          ),
        ),
      );
    }
  }

  String getPatientAge() {
    if (hasPatient()) {
      if (patient.idade == 1) {
        return '${patient.idade} ano';
      } else {
        return '${patient.idade} anos';
      }
    } else {
      return '';
    }
  }

  String getPatientName() {
    if (hasPatient()) {
      return patient.identificador;
    } else {
      return 'Selecione o Paciente';
    }
  }
}
