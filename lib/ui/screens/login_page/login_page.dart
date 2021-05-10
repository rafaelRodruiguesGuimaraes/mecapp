import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final snackBar = SnackBar(
    content: Text(
      'E-mail ou senha incorreto!',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.red,
  );

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final formKey = GlobalKey<FormState>();

  login() async {
    var res = await db.collection("users").get();

    res.docs.forEach(
      (e) async {
        var user_data = await db.collection("users").doc(e.id).get();
        var user = user_data.data();
        if (user['password'] == password.text && user['email'] == email.text) {
          final SharedPreferences prefs = await _prefs;

          prefs.setString("id_user", user_data.id);
          prefs.setString("user_name", user['name']);
          await prefs.setBool("logado", true);

          Navigator.pushNamed(context, '/home_page');

          return;
        }
        if (user['password'] != password.text) {
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);

          //ScaffoldMessenger.of(context).hideCurrentSnackBar();
          return;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Container(
                  child: Image(
                    image: AssetImage('images/logo_app.jpg'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60.0,
                    ),
                    Text(
                      'Entrar',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: email,
                            decoration: InputDecoration(
                              hintText: 'Seu e-mail',
                              hintStyle: TextStyle(color: Colors.black26),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              fillColor: Color(0xffF6F6F8),
                              filled: true,
                            ),
                            validator: (value) {
                              if (!value.contains('@'))
                                return 'E-mail incorreto';

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                              hintText: 'Sua senha',
                              hintStyle: TextStyle(color: Colors.black26),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              fillColor: Color(0xffF6F6F8),
                              filled: true,
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value.length < 6) return 'Senha incorreta';

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (formKey.currentState.validate()) {
                                login();
                              }
                            },
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/registration_page');
                            },
                            child: Text(
                              'Cadastrar-se',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/password_recover_page');
                            },
                            child: Text(
                              'Esqueci minha senha',
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
