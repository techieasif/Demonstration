import 'dart:io';
import '../../../src/shared_wigets/themeChange.dart';
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
    } else if (_imgs.length > 5) {
      return Text(
          'More than 5 images Selected \n Please select up to 5 images');
    } else {
      return SliderWidget(
        imageList: _imgs,
        imageBorderRadius: BorderRadius.circular(8.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Show"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                changeTheme(context);
              })
        ],
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
  AspectRatioVideoState createState() =>  AspectRatioVideoState();
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
      return Center(
        child: AspectRatio(
          aspectRatio: size.width / size.height,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}
