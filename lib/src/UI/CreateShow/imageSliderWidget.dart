import 'dart:async';
import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final List<File> imageList;
  final BorderRadius imageBorderRadius;
  final Duration duration;
  const SliderWidget({
    Key key,
    @required this.imageList,
    @required this.imageBorderRadius,
    this.duration,
  }) : super(key: key);
  @override
  ImageSliderWidgetState createState() {
    return new ImageSliderWidgetState();
  }
}

class ImageSliderWidgetState extends State<SliderWidget> {
  List<Widget> _pages = [];
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    _pages = widget.imageList.map((url) {
      return _buildImagePageItem(url);
    }).toList();

    ///Slide show, it will stop after 1 round
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        int nextPage = _controller.page.round() + 1;
        _controller.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn);
        if (nextPage == _pages.length) {
          _controller.jumpTo(0);
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildingImageSlider();
  }

  Widget _buildingImageSlider() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        children: [
          _buildPagerViewSlider(),
        ],
      ),
    );
  }

  int nextPage = 0;
  Widget _buildPagerViewSlider() {
    return PageView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _controller,
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          return _pages[index % _pages.length];
        });
  }

  Widget _buildImagePageItem(File imgUrl) {
    return ClipRRect(
      borderRadius: widget.imageBorderRadius,
      child: Image.file(imgUrl),
    );
  }
}
