import 'package:flutter/material.dart';

class AlertDialogCustom extends StatelessWidget {
  final String title;
  final String content;

  const AlertDialogCustom(
      {Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        GestureDetector(
          child: const Text('了解'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
