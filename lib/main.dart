import 'package:flutter/material.dart';
import 'package:flutter_aksara/screens/main_screen.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'blocs/main_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.cyan, fontFamily: "Notosans"),
      home: Injector(
        models: [() => MainBloc()],
        builder: (_, __) => MainScreen(),
      ),
    );
  }
}
