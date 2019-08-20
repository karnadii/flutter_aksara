import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aksara/blocs/main_bloc.dart';
import 'package:flutter_aksara/screens/fullscreen.dart';
import 'package:flutter_aksara/screens/settings_screen.dart';
import 'package:share/share.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Injector.get<MainBloc>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Aksårå",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (Context) => SettingScreen()));
            },
          )
        ],
      ),
      body: Builder(
        builder: (context) => StateBuilder(
          tag: "main",
          viewModels: [bloc],
          initState: (_, __) => bloc.init(),
          dispose: (_, __) => bloc.dispose(),
          builder: (_, __) => SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  PreferredSize(
                    preferredSize: Size(size.width, 56),
                    child: Material(
                      color: Colors.white,
                      elevation: 4,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 56,
                                width: size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  bloc.mode == MODE.JAVA_TO_LATIN
                                      ? "Aksara"
                                      : "Latin",
                                  style: TextStyle(
                                    color: Colors.cyan,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Notosans",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                icon: Icon(Icons.swap_horiz,
                                    size: 32, color: Colors.cyan),
                                onPressed: () {
                                  if (bloc.mode == MODE.JAVA_TO_LATIN) {
                                    bloc.mode = MODE.LATIN_TO_JAVA;
                                    bloc.textCtrl.text = bloc.latinScript;
                                  } else {
                                    bloc.mode = MODE.JAVA_TO_LATIN;
                                    bloc.textCtrl.text = bloc.javaScript;
                                  }
                                  bloc.rebuildStates(["main"]);
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 56,
                                width: size.width,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  bloc.mode == MODE.JAVA_TO_LATIN
                                      ? "Latin"
                                      : "Aksara",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.cyan,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Notosans",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 4,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20.0, bottom: 20, top: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 30,
                            child: Row(
                              children: <Widget>[
                                Spacer(),
                                if (bloc.textCtrl.text.length != 0)
                                  IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      bloc.textCtrl.clear();
                                      bloc.javaScript = "";
                                      bloc.latinScript = "";
                                      bloc.rebuildStates(["main"]);
                                    },
                                  )
                              ],
                            ),
                          ),
                          TextField(
                            controller: bloc.textCtrl,
                            maxLines: null,
                            style: TextStyle(
                                fontFamily: bloc.mode == MODE.JAVA_TO_LATIN
                                    ? "Ramayana"
                                    : "Notosans",
                                fontSize: bloc.fontSize),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: bloc.mode == MODE.JAVA_TO_LATIN
                                    ? "Masukkan aksara jawa..."
                                    : "Masukkan huruf latin..."),
                            onChanged: (String str) {
                              if (bloc.mode == MODE.JAVA_TO_LATIN) {
                                bloc.javaScript = str;
                                bloc.toLatin();
                              } else {
                                bloc.latinScript = str;
                                bloc.toJava();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(10)),
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            bloc.mode == MODE.JAVA_TO_LATIN
                                ? bloc.latinScript
                                : bloc.javaScript,
                            style: TextStyle(
                                fontSize: bloc.fontSize,
                                fontFamily: bloc.mode == MODE.JAVA_TO_LATIN
                                    ? "Notosans"
                                    : "Ramayana",
                                color: Colors.grey[100]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            children: <Widget>[
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.content_copy,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  ClipboardManager.copyToClipBoard(
                                          bloc.mode == MODE.JAVA_TO_LATIN
                                              ? bloc.latinScript
                                              : bloc.javaScript)
                                      .then((result) {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.cyan,
                                      content: Text(
                                        'Teks telah di salin',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      action: SnackBarAction(
                                        textColor: Colors.white,
                                        label: 'Ok',
                                        onPressed: () {},
                                      ),
                                    );
                                    Scaffold.of(context).showSnackBar(snackBar);
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.share, color: Colors.white),
                                onPressed: () {
                                  Share.share(bloc.mode == MODE.JAVA_TO_LATIN
                                      ? bloc.latinScript
                                      : bloc.javaScript);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.fullscreen, color: Colors.white),
                                onPressed: () {
                                 Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => Fullscreen(text:bloc.mode == MODE.JAVA_TO_LATIN
                                      ? bloc.latinScript
                                      : bloc.javaScript)));
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
