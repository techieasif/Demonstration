import 'package:assignmentwebkulasif/src/UI/Login/PhoneLogin/Bloc/bloc.dart';
import 'package:assignmentwebkulasif/src/UI/Login/PhoneLogin/pages/phoneLoginForm.dart';
import 'package:assignmentwebkulasif/src/UI/Login/loginOptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_delegate.dart';
import 'src/UI/homescreen.dart';
void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sans',
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: HomeScreen(),
      routes: appRoutes,
    );
  }

  final appRoutes = <String, WidgetBuilder>{
    LoginOptionsScreen.loginOptions: (BuildContext context) => LoginOptionsScreen(),
    PhoneLoginForm.phoneLoginForm: (BuildContext context) => BlocProvider(
      create: (context) => PhoneLoginBloc(),
      child: PhoneLoginForm(),
    ),
  };
}
