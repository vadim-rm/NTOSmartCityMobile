import 'package:flutter/material.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/rounded_button.dart';

class BluetoothView extends StatelessWidget {
  const BluetoothView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text("Проверка станции")),
      body: ListView(
        children: [
          RoundedButton(
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
