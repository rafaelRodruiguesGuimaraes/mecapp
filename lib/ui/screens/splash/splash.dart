import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  //Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void navigationPage() async {
    // final SharedPreferences prefs = await _prefs;
    // bool logado = prefs.getBool("logado");
    // if (logado == null) {
    //   Navigator.pushNamed(context, '/login_page');
    //   return;
    // }
    // !logado
    //     ? Navigator.pushNamed(context, '/login_page')
    //     : Navigator.pushNamed(context, '/home_page');

    Navigator.pushNamed(context, '/login_page');
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Center(
            child: Text(
              "Seu Logo",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
