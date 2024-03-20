import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_quiz/services/databaseConection.dart';
import 'package:on_quiz/services/model.dart';
import 'package:on_quiz/services/services.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final"

  @override
  State<RegistrationPage> createState() => _MyRegistrationPageState();
}

class _MyRegistrationPageState extends State<RegistrationPage> {
  final Login = TextEditingController();
  final Password = TextEditingController();
  final RepeatPassword = TextEditingController();
  final Phone = TextEditingController();
  final Email = TextEditingController();
  String ErrorMes = "";
  bool isError = false;
  DbConnection dbConnection = DbConnection();
  DatabaseConection dbCon = DatabaseConection();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    Login.dispose();
    Password.dispose();
    RepeatPassword.dispose();
    Phone.dispose();
    Email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 93, 108, 215),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.popAndPushNamed(context, '/');
        },
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10)),
                  Text(
                    "Регистрация",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "OpenSans-SemiBold",
                        fontSize: 32),
                  ),
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03)),
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
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                  Container(
                    child: SizedBox(
                      width: 246,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        style: TextStyle(
                            color: Color.fromARGB(200, 40, 49, 73),
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22),
                        controller: Login,
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
                          hintText: "Логин",
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          hintStyle: TextStyle(
                              color: Color.fromARGB(105, 40, 49, 73),
                              fontFamily: "OpenSans-SemiBold",
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,)),
                  Container(
                    child: SizedBox(
                      width: 246,
                      height: MediaQuery.of(context).size.height * 0.06,
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
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,)),
                  Container(
                    child: SizedBox(
                      width: 246,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        style: TextStyle(
                            color: Color.fromARGB(200, 40, 49, 73),
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22),
                        controller: RepeatPassword,
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
                          hintText: "Повтор пароля",
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          hintStyle: TextStyle(
                              color: Color.fromARGB(105, 40, 49, 73),
                              fontFamily: "OpenSans-SemiBold",
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03)),
                  Container(
                    child: SizedBox(
                      width: 246,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        controller: Phone,
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
                          hintText: "Телефон",
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          hintStyle: TextStyle(
                              color: Color.fromARGB(105, 40, 49, 73),
                              fontFamily: "OpenSans-SemiBold",
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03)),
                  Container(
                    child: SizedBox(
                      width: 246,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        controller: Email,
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
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1)),
                  Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        List<UserM> newUsers = [];
                        QuerySnapshot querySnapshot = await users.get();
                        final allData =
                            querySnapshot.docs.map((doc) => doc.data()).toList();
                        for (int i = 0; i < allData.length; i++) {
                          newUsers.add(new UserM(
                              Login: querySnapshot.docs[i].get('Login'),
                              Phone: querySnapshot.docs[i].get('Phone'),
                              id:  querySnapshot.docs[i].get('id')));
                        }
                        if (Password.text != "" &&
                            RepeatPassword.text != "" &&
                            Email.text != "" &&
                            Phone.text != "" &&
                            Login.text != "") {
                          if (Password.text == RepeatPassword.text) {
                            if (Password.text.length >= 6) {
                              if (isValidEmail(Email.text)) {
                                if (isValidPhoneNumber(Phone.text)) {
                                  int index = 0;
        
                                  UserModel? user = await dbConnection.signIn(
                                      Email.text, Password.text);
        
                                  if (newUsers
                                          .where(
                                              (element) => element.Login == Login)
                                          .length ==
                                      0) {
                                    if (user == null) {
                                      user = await dbConnection.signUp(
                                          Email.text, Password.text);
                                      dbCon.uid = user?.id;
                                      dbCon.updateUserData(
                                          Login.text, Phone.text, dbCon.uid.toString());
                                      Navigator.pushNamed(context, '/');
                                    } else {
                                      setState(() {
                                        ErrorMes =
                                            "Такой пользователь уже существует";
                                        isError = true;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      ErrorMes =
                                          "Пользователь с таким логином уже существует";
                                      isError = true;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    ErrorMes = "Некоректный номер";
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
                              ErrorMes = "Пароли не совподают";
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
                        "Зарегистрироваться",
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
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isValidEmail(String? str) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(str!);
}

bool isValidPhoneNumber(String? value) =>
    RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
        .hasMatch(value ?? '');

class UserM {
  String? Login;
  String? Phone;
  String? id;
  UserM({this.Login, this.Phone, this.id});

  UserM.romJson(Map data) {
    Login = data['Login'];
    Phone = data['Phone'];
    id = data['id'];

  }

  static fromMap(value) {}
}
