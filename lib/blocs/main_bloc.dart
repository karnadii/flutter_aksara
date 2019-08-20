import 'package:aksara/aksara.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

// the name is a bloc, but this is not a bloc.
class MainBloc extends StatesRebuilder {
  String javaScript = "";
  String latinScript = "";
  MODE mode = MODE.LATIN_TO_JAVA;
  TextEditingController textCtrl;
  double fontSize = 24.0;
  bool isMurda = false, isCopas = true, isSpasi = true, isKuna = false;
  init() {
    textCtrl = TextEditingController();
  }

  dispose() {
    textCtrl.dispose();
  }

  toLatin() {
    var aksara = AksaraJawaModern();

    latinScript = aksara.javaToLatin(javaScript);
    rebuildStates(["main"]);
  }

  toJava() {
    var aksara;

    if (isKuna) {
      aksara = AksaraJawaKuna();
    } else {
      aksara = AksaraJawaModern();
    }
    javaScript = aksara.latinToJava(latinScript);
    rebuildStates(["main"]);
  }

  onFontChanged(double val){
    fontSize = val;
    rebuildStates(["main","setting"]);

  }
}

enum MODE { JAVA_TO_LATIN, LATIN_TO_JAVA }
