import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({Key key, this.title = 'Alert', this.message})
      : super(key: key);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    Key key,
    this.title = 'Confirm',
    this.message,
    this.onNoPressed,
    this.onYesPressed,
  }) : super(key: key);

  final String title;
  final String message;
  final VoidCallback onNoPressed;
  final VoidCallback onYesPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
                if (onNoPressed != null) {
                  onNoPressed();
                }
              },
              child: const Text('No')),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              if (onYesPressed != null) {
                onYesPressed();
              }
            },
            child: const Text('Yes'),
          )
        ]);
  }
}
