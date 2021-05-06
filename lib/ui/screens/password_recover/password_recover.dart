import 'package:app/ui/components/text_input.dart';
import 'package:flutter/material.dart';

class PasswordRecover extends StatefulWidget {
  @override
  _PasswordRecoverState createState() => _PasswordRecoverState();
}

class _PasswordRecoverState extends State<PasswordRecover> {
  bool inputError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text('Recuperar senha'),
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
                  child: Column(
                    children: [
                      TextInput(
                        inputError: inputError,
                        title: 'Nova senha',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextInput(
                        inputError: inputError,
                        title: 'Confirmar nova senha',
                        obscureText: true,
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
                              'Confirmar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
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
