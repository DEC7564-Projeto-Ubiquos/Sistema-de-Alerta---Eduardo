import 'package:flutter/material.dart';

class SampleCard extends StatelessWidget {
  final String nome;
  final String valor;
  const SampleCard({
    super.key,
    required this.nome,
    required this.valor,
  });

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
            SizedBox(
              width: 140,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/card_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(nome, style: textTheme.titleSmall),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(valor, style: textTheme.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Medir',
                  style: TextStyle(
                    color: Color.fromARGB(255, 98, 0, 238),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
