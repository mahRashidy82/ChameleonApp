import 'package:flutter/material.dart';

showMassege(BuildContext context, String message,
    {String? positiveActionName,
    VoidCallback? positiveAction,
    String? negativeActionName,
    VoidCallback? negativeAction,
    bool isCancelable = true}) {
  List<Widget> actions = [];
  if (positiveActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (positiveAction != null) {
            positiveAction();
          }
        },
        child: Text(positiveActionName)));
  }
  if (negativeActionName != null) {
    actions.add(
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (negativeAction != null) {
              negativeAction();
            }
          },
          child: Text(negativeActionName)),
    );
  }

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
          ),
          actions: actions,
        );
      },
      barrierDismissible: isCancelable);
}

void showLoadingDialog(BuildContext context, String message,
    {bool isCancelable = false}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                message,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              CircularProgressIndicator(),
            ],
          ),
        );
      },
      barrierDismissible: isCancelable);
}

void hideLoadingDialog(BuildContext context) {
  Navigator.pop(context);
}
