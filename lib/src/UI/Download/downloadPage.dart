import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../src/Helpers/formValidators.dart';
import '../../../src/appStyles/containerDecoration.dart';
import '../../../src/appStyles/textFieldDecorations.dart';
import '../../../src/shared_wigets/themeChange.dart';

class DownloadImage extends StatefulWidget {
  @override
  _DownloadImageState createState() => _DownloadImageState();
}

class _DownloadImageState extends State<DownloadImage> {
  int _total = 0, _received = 0;
  http.StreamedResponse _response;
  List<int> _bytes = [];
  final _scfKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String errorMsg = '';
  var _dir;
  String _url =
      "https://www.cdc.gov/coronavirus/2019-ncov/downloads/2019-ncov-factsheet.pdf";
  bool _autoValidate = false;
  String enteredUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: (){
                changeTheme(context);
              }
          )
        ],
      ),
      key: _scfKey,
      floatingActionButton: FloatingActionButton.extended(
          label: Text("${_received  ~/ 1024}/${_total ~/ 1024} KB"),
          icon: Icon(Icons.file_download),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              setState(() {
                _received = 0;
                _total = 0;
              });
              _downloadImage();
            } else {
              setState(() {
                _autoValidate = true;
              });
            }
          }),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                    autovalidate: _autoValidate,
                    keyboardType: TextInputType.text,
                    maxLines: 6,
                    minLines: 1,
                    style: Theme.of(context).textTheme.bodyText1,
                    validator: FormValidators.urlValidator,
                    decoration: textFieldDecoration(hintText: "url ", context: context),
                    onChanged: (value) {
                      this.enteredUrl = value;
                      setState(() {
                        errorMsg = "";
                      });
                    }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "$errorMsg",
                  style: titleStyle.copyWith(
                      color: Colors.red.shade800, fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


//File Downloading logic
  Future<void> _downloadImage() async {
    try {
      _response =
      await http.Client().send(http.Request('GET', Uri.parse(enteredUrl)));
      if(_response.contentLength != null){
      _total = _response.contentLength;
      }else{
        _scfKey.currentState.showSnackBar(SnackBar(content: Text("looks like , not an exact download url"),));
      }



      _response.stream.listen((value) {
        setState(() {
          errorMsg = "";
          _bytes.addAll(value);
          _received += value.length;
        });
      }).onDone(() async {
        if (null == _dir) {
          if (Platform.isAndroid) {
            _dir = (await getExternalStorageDirectory()).path;
          } else {
            _dir = (await getApplicationDocumentsDirectory()).path;
          }
        }

        final file = File("$_dir/webkul");
        await file.writeAsBytes(_bytes);
        _scfKey.currentState?.showSnackBar(SnackBar(
          content: Text("Download Complete, location $file"),
        ));
      });
    } on SocketException {
      setState(() {
        errorMsg = 'Connection lost';
      });
    } on FormatException {
      setState(() {
        errorMsg = 'url not valid';
      });
    } catch (e) {
      debugPrint("Error at Downloading file:-> $e");
      setState(() {
        errorMsg = "$e";
      });
    }
  }
}
