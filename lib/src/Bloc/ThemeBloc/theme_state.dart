import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class InitialThemeState extends ThemeState {
  final ThemeData themeData;

  InitialThemeState(this.themeData);
  @override
  List<Object> get props => [themeData];
}
class NewThemeState extends ThemeState {
  final ThemeData themeData;

  NewThemeState({@required this.themeData});
  @override
  List<Object> get props => [themeData];
}
