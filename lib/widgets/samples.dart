import 'package:emg_app/widgets/sample_card.dart';
import 'package:flutter/material.dart';

class Samples extends StatefulWidget {
  const Samples({Key? key}) : super(key: key);

  @override
  State<Samples> createState() => _SamplesState();
}

class _SamplesState extends State<Samples> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: SizedBox(
        width: (MediaQuery.of(context).size.width * 0.75) - 32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: const Row(
                children: [
                  SampleCard(
                    nome: 'Referência',
                    valor: '100%',
                  ),
                  SampleCard(
                    nome: 'Amostra 1',
                    valor: '97.5%',
                  ),
                  SampleCard(
                    nome: 'Amostra 2',
                    valor: '89.6%',
                  ),
                  SampleCard(
                    nome: 'Atual',
                    valor: '98.1%',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _scrollController.animateTo(
                      _scrollController.offset - (140 + 16),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: null,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _scrollController.animateTo(
                      _scrollController.offset + (140 + 16),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: null,
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
