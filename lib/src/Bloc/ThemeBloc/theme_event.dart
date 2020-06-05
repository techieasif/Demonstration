import '../../../src/appStyles/appTheme.dart';
import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged(this.theme);

  @override
  List<Object> get props => [theme];
}
