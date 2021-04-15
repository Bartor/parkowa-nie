import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/widgets/ImagePreview.dart';

showImagePreview(List<String> photos, int index, {bool deletable = false}) =>
    PageRouteBuilder<ImagePreviewState>(
        transitionsBuilder: (context, primary, secondary, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: primary, curve: Curves.ease),
            child: child,
          );
        },
        opaque: false,
        barrierColor: Colors.black87,
        barrierDismissible: true,
        pageBuilder: (_, __, ___) {
          return ImagePreview(
            initialPhotoIndex: index,
            photos: photos,
            deletable: deletable,
          );
        });
