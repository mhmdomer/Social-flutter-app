import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  PhotoViewer({@required this.imageUrl}) : assert(imageUrl != null);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: NetworkImage(imageUrl),
      ),
    );
  }
}
