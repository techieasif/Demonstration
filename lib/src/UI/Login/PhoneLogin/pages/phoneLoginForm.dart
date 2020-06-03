import 'package:assignmentwebkulasif/src/Helpers/formValidators.dart';
import 'package:assignmentwebkulasif/src/appStyles/textFieldDecorations.dart';
import 'package:assignmentwebkulasif/src/UI/Login/PhoneLogin/Bloc/bloc.dart';
import 'package:assignmentwebkulasif/src/UI/Login/PhoneLogin/pages/phoneLoginSuccess.dart';
import 'package:assignmentwebkulasif/src/UI/Login/PhoneLogin/services/phoneLoginService.dart';
import 'package:assignmentwebkulasif/src/UI/Login/PhoneLogin/widgets/bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneLoginForm extends StatefulWidget {
  static const phoneLoginForm = '/phone-login-form';
  @override
  _PhoneLoginFormState createState() => _PhoneLoginFormState();
}

class _PhoneLoginFormState extends State<PhoneLoginForm> {
  final _phoneFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;
  bool showBtnloader = false;
  TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
  String phoneNo, verificationId, smsCode;
  bool codeSent = false;
  @override
  Widget build(BuildContext context) {
    final loader = Container(
      width: 50,
      height: 50,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _phoneFormKey,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text('Phone Login with Firebase Auth'),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      autovalidate: _autoValidate,
                      keyboardType: TextInputType.text,
                      validator: FormValidators.phoneNumberValidator,
                      controller: phoneController,
                      decoration: textFieldDecoration(hintText: "Phone "),
                    ),
                    SizedBox(height: 20),
                    codeSent ? Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 50),
                        child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.phone,
                          decoration: textFieldDecoration(hintText: "otp "),
                          onChanged: (val) {
                            setState(() {
                              this.smsCode = val;
                            });
                          },
                        )) : Container(),
                    RaisedButton(
                      child: codeSent? Text("Enter OTP") : Text("Login"),
                      onPressed: () {
                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Bubbles(
                bigCircleColor: Colors.deepOrange,
                smallCircleColor: Colors.blue,
                height: 60,
              ),
            ),

          ],
        ),
      ),
//      BlocListener<PhoneLoginBloc, PhoneLoginState>(
//        listener: (context, state) {
//          if (state is LoadedPhoneLoginState) {
//            showBtnloader = false;
////            _scaffoldKey.currentState
////              ..hideCurrentSnackBar()
////              ..showSnackBar(
////                SnackBar(
////                  content: Text("${state.loginData}"),
////                ),
////              );
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => PhoneLoginSuccess(
//                  data: state.loginData,
//                ),
//              ),
//            );
//          }
//        },
//        child: BlocBuilder<PhoneLoginBloc, PhoneLoginState>(
//            builder: (context, state) {
//          if (state is InitialPhoneLoginState) {
//            return loginForm(context);
//          } else if (state is LoadingPhoneLoginState) {
//            return loginForm(context);
//          } else if (state is LoadedPhoneLoginState) {
//            return loginForm(context);
//          } else if (state is ErrorPhoneLoginState) {
//            return Container();
//          } else {
//            return Container();
//          }
//        }),
//      ),
    );
  }
  Future<void> verifyPhone(phoneNo) async {
    if (_phoneFormKey.currentState.validate()) {
      setState(() {
        showBtnloader = true;
      });
//      BlocProvider.of<PhoneLoginBloc>(context).add(
//        NewPhoneLoginEvent(
//          phoneNumber: phoneController.text,
//        ),
//      );
      final PhoneVerificationCompleted verified = (AuthCredential authResult) async{

        final FirebaseUser currentUser = await AuthService().signIn(authResult);
        debugPrint("Condition HIT");
        setState(() {
          if(currentUser != null){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneLoginSuccess(data: "${currentUser.phoneNumber}",)));
          }else{
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Login Failed"),));
          }
        });
      };

      final PhoneVerificationFailed verificationfailed =
          (AuthException authException) {
        print('ERROR::?>>>>${authException.message}');
      };

      final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
        this.verificationId = verId;
        setState(() {
          this.codeSent = true;
        });
      };

      final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
        this.verificationId = verId;
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91" + phoneNo,
          timeout: const Duration(seconds: 30),
          verificationCompleted: verified,
          verificationFailed: verificationfailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: autoTimeout);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }

  }

}
