import 'package:flutter/material.dart';
class PhoneLoginSuccess extends StatelessWidget {
  final String data;

  const PhoneLoginSuccess({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Success'),
        ),
        body: Center(child: Text("$data"),)
    );
  }
}
