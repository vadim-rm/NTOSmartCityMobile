import 'package:flutter/material.dart';

class CardWithTitle extends StatelessWidget {
  final String title;
  final Widget body;

  const CardWithTitle({
    required this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            body,
          ],
        ),
      ),
    );
  }
}
