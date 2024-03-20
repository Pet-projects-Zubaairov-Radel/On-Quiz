import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_quiz/services/services.dart';
import 'package:provider/provider.dart';
import 'authPage.dart';
import 'registrationPage.dart';
import 'mainPage.dart';
import 'myquiz.dart';
import 'createQuestion.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyThemeApp());
}

class MyThemeApp extends StatelessWidget {
  const MyThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: DbConnection().currentUser,
        initialData: null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const AuthPage(),
            '/regPage': (context) => const RegistrationPage(),
            '/mainPage': (context) => const MainPage(),
            '/myquiz': (context) => const MyQuizPage(),
            '/createQuestion': (context) => const CreateQuestion(),
          },
        ));
  }
}
