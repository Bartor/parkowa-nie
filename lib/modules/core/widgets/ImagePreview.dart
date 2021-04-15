import 'dart:io';

import 'package:parkowa_nie/modules/core/common/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

enum ImagePreviewState { delete }

class ImagePreview extends StatefulWidget {
  final bool deletable;
  final int initialPhotoIndex;

  List<FileImage> photoList;

  ImagePreview(
      {List<String> photos, this.initialPhotoIndex, this.deletable = false}) {
    photoList = photos.map((e) => FileImage(File(e))).toList();
  }

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialPhotoIndex);
  }

  Future<void> _saveImage() async {
    await ImageGallerySaver.saveFile(
        widget.photoList[_controller.page.toInt()].file.path);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Image saved to gallery".i18n)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                icon: Icon(Icons.save_alt_rounded), onPressed: _saveImage),
            widget.deletable
                ? IconButton(
                    icon: Icon(Icons.delete_rounded),
                    onPressed: () {
                      Navigator.of(context).pop(ImagePreviewState.delete);
                    })
                : SizedBox.shrink(),
          ],
        ),
        body: PhotoViewGallery.builder(
          backgroundDecoration: BoxDecoration(color: Colors.transparent),
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: widget.photoList[index],
              minScale: PhotoViewComputedScale.contained * 0.8,
              initialScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.contained * 4,
              heroAttributes: PhotoViewHeroAttributes(
                  tag: "image/${widget.photoList[index].file.path}"),
            );
          },
          itemCount: widget.photoList.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes,
              ),
            ),
          ),
          pageController: _controller,
        ));
  }
}
