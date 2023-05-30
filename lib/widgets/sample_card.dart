import 'package:emg_app/models/sample.dart';
import 'package:emg_app/services/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SampleCard extends StatefulWidget {
  final Sample sample;
  final Color color;
  const SampleCard({
    super.key,
    required this.sample,
    required this.color,
  });

  @override
  State<SampleCard> createState() => _SampleCardState();
}

class _SampleCardState extends State<SampleCard> {
  late PatientProvider patientProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    patientProvider = Provider.of<PatientProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                color: widget.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(widget.sample.name, style: textTheme.titleSmall),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                  widget.sample.value == -1
                      ? '-'
                      : '${widget.sample.value.toString()}%',
                  style: textTheme.titleMedium),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 2, 8),
                  child: Tooltip(
                    message: 'Medir Novamente',
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.restart_alt,
                        color: widget.color,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
                  child: Tooltip(
                    message: 'Renomear',
                    child: IconButton(
                      onPressed: () {
                        patientProvider.showRenameSampleDialog(
                            context, widget.sample);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: widget.color,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 8, 4, 8),
                  child: Tooltip(
                    message: 'Excluir',
                    child: IconButton(
                      onPressed: () {
                        patientProvider.deleteSample(widget.sample, context);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: widget.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
