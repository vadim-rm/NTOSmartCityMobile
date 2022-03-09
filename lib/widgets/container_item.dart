import 'package:flutter/material.dart';
import 'package:nagib_pay/models/container.dart';

class ContainerItem extends StatelessWidget {
  final TrashContainer container;

  const ContainerItem({
    Key? key,
    required this.container,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            const Image(
              height: 80,
              width: 80,
              image: AssetImage("assets/basket.png"),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              container.typeDescription,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }
}
