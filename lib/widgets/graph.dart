import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 16, 0),
      child: Row(
        children: [
          Container(
            color: const Color.fromARGB(25, 98, 0, 238),
            height: 300,
            width: 100,
          ),
          Container(
            color: const Color.fromARGB(50, 98, 0, 238),
            height: 300,
            width: (MediaQuery.of(context).size.width * 0.75) - 140,
          ),
        ],
      ),
    );
  }
}
