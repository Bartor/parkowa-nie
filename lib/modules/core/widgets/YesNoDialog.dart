import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/common/i18n.dart';

class YesNoDialog extends StatelessWidget {
  final Widget title;
  final Widget content;

  YesNoDialog({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("No".i18n)),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Yes".i18n)),
      ],
    );
  }
}
