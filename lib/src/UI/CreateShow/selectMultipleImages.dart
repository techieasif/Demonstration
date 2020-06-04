//import 'package:flutter/material.dart';
//import 'dart:async';
//import 'package:multi_image_picker/multi_image_picker.dart';
//class SelectMultipleImagesScreen extends StatefulWidget {
//  @override
//  _SelectMultipleImagesScreenState createState() => _SelectMultipleImagesScreenState();
//}
//
//class _SelectMultipleImagesScreenState extends State<SelectMultipleImagesScreen> {
//  List<Asset> images = List<Asset>();
//  String _error;
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  Widget buildGridView() {
//    if (images != null)
//      return GridView.count(
//        crossAxisCount: 3,
//        children: List.generate(images.length, (index) {
//          Asset asset = images[index];
//          return AssetThumb(
//            asset: asset,
//            width: 300,
//            height: 300,
//          );
//        }),
//      );
//    else
//      return Container(color: Colors.white);
//  }
//
//  Future<void> loadAssets() async {
//    setState(() {
//      images = List<Asset>();
//    });
//
//    List<Asset> resultList;
//    String error;
//
//    try {
//      resultList = await MultiImagePicker.pickImages(
//        maxImages: 5,
//      );
//    } on Exception catch (e) {
//      error = e.toString();
//    }
//
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) return;
//
//    setState(() {
//      images = resultList;
//      if (error == null) _error = 'No Error Dectected';
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return
//    Scaffold(
//      appBar:  AppBar(
//        title: const Text('Select Images'),
//      ),
//      body: Column(
//        children: <Widget>[
//          Center(child: Text('Error: $_error')),
//          RaisedButton(
//            child: Text("Pick images"),
//            onPressed: loadAssets,
//          ),
//          Expanded(
//            child: buildGridView(),
//          )
//        ],
//      ),
//    );
//  }
//}
//import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_media_picker/multi_media_picker.dart';
import 'package:video_player/video_player.dart';

import 'imageSliderWidget.dart';

class SelectMultipleImages extends StatefulWidget {
  @override
  _SelectMultipleImagesState createState() => _SelectMultipleImagesState();
}

class _SelectMultipleImagesState extends State<SelectMultipleImages> {
  List<File> _imgs;
  bool isVideo = false;
  VideoPlayerController _controller;
  VoidCallback listener;

  _onImageButtonPressed(ImageSource source, {bool singleImage = false}) async {
    var imgs;
    if (!isVideo) {
      imgs = await MultiMediaPicker.pickImages(
          source: source, singleImage: singleImage);
    }
    setState(() {
      if (_controller != null) {
        _controller.setVolume(0.0);
        _controller.removeListener(listener);
      }
      if (isVideo) {
        MultiMediaPicker.pickVideo(source: source).then((File file) {
          if (file != null && mounted) {
            setState(() {
              _controller = VideoPlayerController.file(file)
                ..addListener(listener)
                ..setVolume(1.0)
                ..initialize()
                ..setLooping(true)
                ..play();
            });
          }
        });
      } else {
        _imgs = imgs;
      }
    });
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(listener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  Widget _previewVideo(VideoPlayerController controller) {
    if (controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    } else if (controller.value.initialized) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: AspectRatioVideo(controller),
      );
    } else {
      return const Text(
        'Error Loading Video',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _previewImages() {
    if (_imgs == null) {
      return Text('No images selected.');
    } else {
      return SliderWidget(imageList: _imgs, imageBorderRadius: BorderRadius.circular(8.0),);
//        GridView.count(
//          crossAxisCount: 2,
//          childAspectRatio: 1.0,
//          padding: EdgeInsets.all(4.0),
//          mainAxisSpacing: 4.0,
//          crossAxisSpacing: 4.0,
//          children: _imgs.map((File img) {
//            return GridTile(child: Image.file(img, fit: BoxFit.contain),
//            );
//          }).toList(),
//      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text(widget.title),
          ),
      body: Center(
        child: isVideo ? _previewVideo(_controller) : _previewImages(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              isVideo = false;
              _onImageButtonPressed(ImageSource.gallery, singleImage: false);
            },
            heroTag: 'fab1',
            tooltip: 'Pick Images from gallery',
            child: Icon(Icons.photo_library),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.gallery);
              },
              heroTag: 'fab2',
              tooltip: 'Pick Video from gallery',
              child: Icon(Icons.video_library),
            ),
          ),
        ],
      ),
    );
  }
}

class AspectRatioVideo extends StatefulWidget {
  final VideoPlayerController controller;

  AspectRatioVideo(this.controller);

  @override
  AspectRatioVideoState createState() => new AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      final Size size = controller.value.size;
      return new Center(
        child: new AspectRatio(
          aspectRatio: size.width / size.height,
          child: new VideoPlayer(controller),
        ),
      );
    } else {
      return new Container();
    }
  }
}
