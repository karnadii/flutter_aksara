import 'package:flutter/material.dart';
import 'package:flutter_aksara/blocs/main_bloc.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Injector.get<MainBloc>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Pengaturan", style: TextStyle(color: Colors.white),),
      ),
      body: StateBuilder(
        viewModels: [bloc],
        tag: "setting",
        builder: (_, __) => Container(
          padding: new EdgeInsets.all(0.0),
          child: new ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Text("Ukuran Font"),
              ),
              ListTile(
                title: Slider(
                  value: bloc.fontSize,
                  max: 30.0,
                  min: 16,
                  divisions: 7,
                  onChanged: bloc.onFontChanged,
                ),
              ),
              CheckboxListTile(
                value: bloc.isKuna,
                title: Text('Cara kunå'),
                subtitle: Text("Gunakan cara kunå"),
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (bool val) {
                  bloc.isKuna = val;
                  bloc.rebuildStates(["setting"]);
                },
              ),
              CheckboxListTile(
                value: bloc.isMurda,
                title: Text('Murdha (Cara modern)'),
                subtitle: Text("Gunakan aksara Murdha"),
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: bloc.isKuna
                    ? null
                    : (bool val) {
                        bloc.isMurda = val;
                        bloc.rebuildStates(["setting"]);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
