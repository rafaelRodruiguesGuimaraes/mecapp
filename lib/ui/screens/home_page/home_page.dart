import 'package:app/ui/components/drawer_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String userName;

  @override
  void initState() {
    super.initState();
    // create database firebase
    // controller.createDatabaseFirebase();
    init();
  }

  init() {
    getUserData();
  }

  getUserData() async {
    final SharedPreferences prefs = await _prefs;

    var userNameData = prefs.getString('user_name');

    print(userName);

    setState(
      () {
        userName = userNameData;
      },
    );
  }

  logout() async {
    final SharedPreferences prefs = await _prefs;

    Navigator.pushNamed(context, '/login_page');
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(onTap: () {
        logout();
      }),
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Text(
                  'Bem vindo, $userName!\nvocê está logado(a).',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
