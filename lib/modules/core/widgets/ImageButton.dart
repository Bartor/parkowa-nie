import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final File photoFile;
  final Function onTap;
  final Function onLongPress;

  ImageButton({this.photoFile, this.onLongPress, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "image/${photoFile.path}",
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: Ink.image(
            image: FileImage(
              photoFile,
            ),
            fit: BoxFit.cover,
            child: InkWell(
              splashColor: Colors.white60,
              onTap: onTap,
            ),
          ),
        ));
  }
}
