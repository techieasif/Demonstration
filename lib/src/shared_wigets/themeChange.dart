import '../../src/Bloc/ThemeBloc/bloc.dart';
import '../../src/appStyles/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void changeTheme(BuildContext context){
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  if(!isDark){
    BlocProvider.of<ThemeBloc>(context)
        .add(ThemeChanged(AppTheme.GreenDark));
  }else{
    BlocProvider.of<ThemeBloc>(context)
        .add(ThemeChanged(AppTheme.GreenLight));
  }
}