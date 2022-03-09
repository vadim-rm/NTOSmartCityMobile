import 'package:flutter/material.dart';
import 'package:nagib_pay/extensions/date_extension.dart';

import '../models/history_action.dart';

class HistoryItem extends StatelessWidget {
  final HistoryAction action;

  const HistoryItem({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            Image(
              height: 40,
              width: 40,
              image: AssetImage(action.imagePath),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 4,
              child: Text(
                action.actionDescription,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                action.date.format(),
                style: Theme.of(context).textTheme.caption,
                // maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
