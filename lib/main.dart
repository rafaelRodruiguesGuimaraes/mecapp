import 'package:app/ui/screens/article_page/article_page.dart';
import 'package:app/ui/screens/password_recover/password_recover.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/screens/home_page/home_page.dart';
import 'ui/screens/login_page/login_page.dart';
import 'ui/screens/registration_page/registration_page.dart';
import 'ui/screens/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff08437d),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash': (context) => Splash(),
        '/login_page': (context) => LoginPage(),
        '/registration_page': (context) => RegistrationPage(),
        '/password_recover_page': (context) => PasswordRecover(),
        '/home_page': (context) => HomePage(),
        '/article_page': (context) => ArticlePage(),
      },
    );
  }
}
