import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/Bloc/ThemeBloc/bloc.dart';
import 'package:flutter/material.dart';
import 'bloc_delegate.dart';
import 'src/UI/homescreen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is InitialThemeState) {
            return _buildWithTheme(context, state.themeData);
          } else if (state is NewThemeState) {
            return _buildWithTheme(context, state.themeData);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  //App will rebuild with theme whenever user change theme.
  Widget _buildWithTheme(BuildContext context, ThemeData themeData) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routes: appRoutes,
      initialRoute: '/',
      themeMode: Theme.of(context).brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }

  //app routes
  final appRoutes = <String, WidgetBuilder>{
    '/': (BuildContext context) => HomeScreen()
  };
}
