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
        getActionButtons(),
      ],
    );
  }

  bool hasPatient() {
    return patient.nome.isNotEmpty;
  }

  getActionButtons() {
    if (hasPatient()) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: () {},
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
    ;
  }

  String getPatientName() {
    if (hasPatient()) {
      return patient.nome;
    } else {
      return 'Selecione o Paciente';
    }
  }
}
