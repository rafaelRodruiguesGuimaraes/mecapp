import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/text_input.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool inputError = false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  register() async {
    var user_data = await db.collection("users").add(
      {
        "name": name.text,
        "email": email.text,
        "password": password.text,
        "confirm_password": confirmPassword.text,
      },
    );
    final SharedPreferences prefs = await _prefs;

    await prefs.setString("user_name", name.text);

    if (user_data.id != null) {
      prefs.getString(
        "id_user",
      );
      await prefs.setBool("logado", true);

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text('Registrar'),
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                Text(
                  'Seu Logo',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 60.0,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextInput(
                        controller: name,
                        title: 'Nome',
                        obscureText: false,
                        validator: (value) {
                          if (value.length < 3) return 'Insira um nome';

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextInput(
                        controller: email,
                        title: 'E-mail',
                        obscureText: false,
                        validator: (value) {
                          if (!value.contains('@')) return 'E-mail inválido';

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextInput(
                        controller: password,
                        title: 'Senha',
                        obscureText: true,
                        validator: (value) {
                          if (value.length < 6)
                            return 'Sua senha deve conter pelo menos 6 caracteres';

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextInput(
                        controller: confirmPassword,
                        title: 'Confirmar senha',
                        obscureText: true,
                        validator: (value) {
                          if (value.length < 6)
                            return 'Sua senha deve conter pelo menos 6 caracteres';

                          if (password.text != confirmPassword.text)
                            return 'As sehas não conferem';

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
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
                              'Registrar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (formKey.currentState.validate()) {
                            register();
                            Navigator.pushNamed(context, '/home_page');
                          }
                        },
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
