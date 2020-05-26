
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final title;
  final message;

  const AppAlertDialog({Key key, this.title = "Alert", this.message})
      : super(key: key);

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
          child: Text('OK'),
        ),
      ],
    );
  }
}

class AppConfirmDialog extends StatelessWidget {
  final title;
  final message;
  final VoidCallback onNoPressed;
  final VoidCallback onYesPressed;

  AppConfirmDialog(
      {this.title = "Confirm",
      this.message,
      this.onNoPressed,
      this.onYesPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
                if (onNoPressed != null) onNoPressed();
              },
              child: Text('No')),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              if (onYesPressed != null) onYesPressed();
            },
            child: Text('Yes'),
          )
        ]);
  }
}
