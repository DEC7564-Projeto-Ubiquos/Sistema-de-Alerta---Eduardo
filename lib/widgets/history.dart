import 'package:emg_app/widgets/history_card.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 24, 12, 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Histórico', style: textTheme.titleLarge),
              Column(
                children: const [
                  HistoryCard(nome: 'Exame 1', data: '21/04/2023'),
                  HistoryCard(nome: 'Exame 2', data: '22/04/2023'),
                  HistoryCard(nome: 'Exame 3', data: '23/04/2023'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
