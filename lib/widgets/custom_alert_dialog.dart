import 'package:flutter/material.dart';

class CustomAlertDialog {
  AlertDialog fromError({required BuildContext context, required String error}) {
    return AlertDialog(
      title: const Text('Произошла ошибка 😢'),
      content: Text(error),
      actions: <Widget>[
        popButton(context: context)
      ],
      titleTextStyle: Theme.of(context).textTheme.bodyText1,
      contentTextStyle: Theme.of(context).textTheme.subtitle1,
    );
  }
}

Widget popButton({String? text, required BuildContext context}) {
  return TextButton(
    child: Text(text ?? 'OK'),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
}