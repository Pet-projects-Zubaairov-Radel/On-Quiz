import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_quiz/createQuizPage.dart';
import 'package:on_quiz/registrationPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_quiz/services/model.dart';
import 'package:on_quiz/services/services.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<AuthPage> {
  DbConnection dbConnection = DbConnection();
  final Email = TextEditingController();
  final Password = TextEditingController();
  String ErrorMes = "";
  bool isError = false;

  @override
  void dispose() {
    Email.dispose();
    Password.dispose();
    super.dispose();
  }

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 93, 108, 215),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  )),
                  Image.asset(
                    'assets/ques_icon.png',
                    width: MediaQuery.of(context).size.height * 0.15,
                    height: MediaQuery.of(context).size.height * 0.15,
                    fit: BoxFit.cover,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    "ОнКвиз",
                    style: TextStyle(
                        color: Color.fromARGB(250, 249, 225, 159),
                        fontFamily: "OpenSans-SemiBold",
                        fontSize: 24),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03)),
                  isError
                      ? Container(
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            ErrorMes,
                            style: TextStyle(
                                color: Color.fromARGB(199, 0, 0, 0),
                                fontFamily: "OpenSans-SemiBold",
                                fontSize: 18),
                          ),
                        )
                      : Container(),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.002)),
                  Text(
                    "Авторизация",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "OpenSans-SemiBold",
                        fontSize: 32),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02)),
                  Container(
                    child: SizedBox(
                      width: 246,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextField(
                        style: TextStyle(
                            color: Color.fromARGB(200, 40, 49, 73),
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22),
                        controller: Email,
                        cursorColor: Color.fromARGB(6, 160, 160, 160),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromARGB(250, 93, 108, 215)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromARGB(250, 93, 108, 215)),
                          ),
                          filled: true,
                          hintText: "Почта",
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          hintStyle: TextStyle(
                              color: Color.fromARGB(105, 40, 49, 73),
                              fontFamily: "OpenSans-SemiBold",
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02)),
                  Container(
                    child: SizedBox(
                      width: 246,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextField(
                        controller: Password,
                        style: TextStyle(
                            color: Color.fromARGB(200, 40, 49, 73),
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22),
                        cursorColor: Color.fromARGB(6, 160, 160, 160),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromARGB(250, 93, 108, 215)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromARGB(250, 93, 108, 215)),
                          ),
                          filled: true,
                          hintText: "Пароль",
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          hintStyle: TextStyle(
                              color: Color.fromARGB(105, 40, 49, 73),
                              fontFamily: "OpenSans-SemiBold",
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.07)),
                  Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (Password.text != "" && Email.text != "") {
                          if (Password.text.length >= 6) {
                            if (isValidEmail(Email.text)) {
                              UserModel? user = await dbConnection.signIn(
                                  Email.text, Password.text);
                              if (user != null) {
                                curUser = user;
                                QuerySnapshot querySnapshot = await users.get();
                                final allData = querySnapshot.docs
                                    .map((doc) => doc.data())
                                    .toList();
                                for (int i = 0; i < allData.length; i++) {
                                  if (querySnapshot.docs[i].get('id') ==
                                      user.id) {
                                    userLogin =
                                        querySnapshot.docs[i].get('Login');
                                  }
                                }
                                Navigator.popAndPushNamed(context, '/mainPage');
                              } else {
                                setState(() {
                                  ErrorMes = "Вы не зарегистрированы";
                                  isError = true;
                                });
                              }
                            } else {
                              setState(() {
                                ErrorMes = "Некоректная почта";
                                isError = true;
                              });
                            }
                          } else {
                            setState(() {
                              ErrorMes = "Пароль должен быть больше 5 символов";
                              isError = true;
                            });
                          }
                        } else {
                          setState(() {
                            ErrorMes = "Не все поля заполнены";
                            isError = true;
                          });
                        }
                      },
                      child: Text(
                        "Войти",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 18),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 58, 40, 167)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                    ),
                    height: MediaQuery.of(context).size.height * 0.045,
                    width: 100,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02)),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/regPage');
                    },
                    child: Text(
                      "Регистрация",
                      style: TextStyle(
                          color: Color.fromARGB(170, 255, 255, 255),
                          fontFamily: "OpenSans-SemiBold",
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

UserModel? curUser;

String userLogin = "";
