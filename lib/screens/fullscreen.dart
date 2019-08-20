import 'package:flutter/material.dart';
import 'package:flutter_aksara/blocs/main_bloc.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Fullscreen extends StatelessWidget {
  final String text;

  const Fullscreen({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Injector.get<MainBloc>();

    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Text(text, style: TextStyle(fontSize: bloc.fontSize,fontFamily: "Ramayana", color: Colors.white),)
      ),
    );
  }
}
