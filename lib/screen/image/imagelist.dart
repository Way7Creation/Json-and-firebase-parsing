import 'package:eclipse/class/photos.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class ImageViewer extends StatefulWidget {
  final PhotosUsers photosUsers;

  const ImageViewer({Key? key, required this.photosUsers}) : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(widget.photosUsers.title),
      ),
      body: ListView(
        children: [
           Container(
             margin: EdgeInsets.all(10),
             width: 400,
             height: 400,
             child: PhotoView(
                  imageProvider: NetworkImage(widget.photosUsers.url),
                  backgroundDecoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                  ),
                 minScale: PhotoViewComputedScale.contained * 0.8,
                 maxScale: PhotoViewComputedScale.covered * 2,
                ),
             ),
          Center(
              child: Text(widget.photosUsers.title),
            ),
        ],
      ),
    );
  }
}
