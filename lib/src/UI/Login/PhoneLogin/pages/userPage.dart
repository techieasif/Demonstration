import 'package:assignmentwebkulasif/src/UI/Login/PhoneLogin/pages/phoneLoginNew.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String userID = "";
  String userPhone = "";
  @override
  void initState(){
    userID= '';
    FirebaseAuth.instance.currentUser().then((val){
      setState(() {
        this.userID = val.uid;
        this.userPhone = val.phoneNumber;
      });
    }).catchError((e){
      print(e);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Text('User'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Text('User Id : $userID'),
               Text('User Phone : $userPhone'),
              SizedBox(height: 10,),
               OutlineButton(
                  borderSide: BorderSide(
                      color: Colors.blue, style: BorderStyle.solid, width: 3
                  ),
                  child: Text('Log out', style: TextStyle( color: Colors.blue),),
                  onPressed: (){
                    FirebaseAuth.instance.signOut().then((action){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }).catchError((e){
                      print(e);
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
