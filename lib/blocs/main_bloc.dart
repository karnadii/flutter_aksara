import 'package:aksara/aksara.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

// the name is a bloc, but this is not a bloc.
class MainBloc extends StatesRebuilder {
  String javaScript = "";
  String latinScript = "";
  MODE mode = MODE.LATIN_TO_JAVA;
  TextEditingController textCtrl;
  bool isMurda = false, isCopas = true, isSpasi = false;
  init() {
    textCtrl = TextEditingController();
  }

  dispose() {
    textCtrl.dispose();
  }

  toLatin() {
    var aksara = AksaraJava();
    latinScript = aksara.javaToLatin(javaScript);
    rebuildStates(["main"]);
  }

  toJava() {
    var aksara = AksaraJava();
    javaScript = aksara.latinToJava(latinScript,
        isMurdha: isMurda, isCopas: isCopas, isSpasi: isSpasi);
    rebuildStates(["main"]);
  }
}

enum MODE { JAVA_TO_LATIN, LATIN_TO_JAVA }
