import 'dart:async';
import '../../../src/appStyles/appTheme.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => InitialThemeState(appThemeData[AppTheme.GreenLight]);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      yield NewThemeState(themeData: appThemeData[event.theme]);
    }
  }
}
