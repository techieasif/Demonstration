import '../../src/appStyles/containerDecoration.dart';
import 'package:flutter/material.dart';
class OptionWidget extends StatelessWidget {
  final String title;
  final VoidCallback fun;
  final Size screenSize;

  const OptionWidget({Key key, @required this.title, @required this.fun, @required this.screenSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: screenSize.width/2.5,
        height: 150,
        decoration: customDecoration,
        child: Center(
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
      ),
    );
  }
}
