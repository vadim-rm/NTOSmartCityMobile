import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const RoundedButton(
      {Key? key, this.text,
        this.child,
        this.padding,
        required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (text != null) Text(text!),
                if (child != null) child!,
              ],
            ),
          )),
    );
  }
}