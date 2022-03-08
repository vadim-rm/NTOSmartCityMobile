import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final String value;
  final String units;
  final Widget image;

  const DataCard({
    Key? key,
    required this.value,
    required this.units,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            image,
            Text(
              value,
              style: const TextStyle(fontSize: 52, letterSpacing: -3),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              units,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}


