import 'package:flutter/material.dart';

class ConfirmAlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;

  const ConfirmAlertDialogWidget({
    Key? key,
    this.title = "Confirm Action",
    this.content = "Are you sure you want to proceed?",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text("Cancelar", style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            "Aceptar",
          ),
        ),
      ],
    );
  }
}
