import 'package:flutter/material.dart';
import '../../src/UI/Login/loginOptions.dart';
import '../../src/shared_wigets/optionWidget.dart';
import '../../src/shared_wigets/themeChange.dart';
import '../shared_wigets/background_gradient.dart';
import 'CreateShow/selectMultipleImages.dart';
import 'Download/downloadPage.dart';
import 'TrackMe/googleMapPage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      floatingActionButton: FlatButton(
        onPressed: () {
          changeTheme(context);
        },
        child: Icon(Icons.lightbulb_outline),
      ),
      body: Stack(
        children: <Widget>[
          isDark ? Container() : backgroundGradient,
          grid(context, screenSize),
        ],
      ),
    );
  }

  ///Feature choice grid.
  Widget grid(BuildContext context, Size screenSize) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OptionWidget(
                  fun: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginOptionsScreen(),
                      ),
                    );
                  },
                  title: "Login",
                  screenSize: screenSize,
                  key: UniqueKey()),
              OptionWidget(
                  fun: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectMultipleImages(),
                      ),
                    );
                  },
                  title: "Create Show",
                  screenSize: screenSize,
                  key: UniqueKey()),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OptionWidget(
                fun: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapsScreen(),
                    ),
                  );
                },
                title: "Track Me",
                screenSize: screenSize,
                key: UniqueKey(),
              ),
              OptionWidget(
                fun: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DownloadImage(),
                    ),
                  );
                },
                title: "Download",
                screenSize: screenSize,
                key: UniqueKey(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
