import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:on_quiz/authPage.dart';
import 'package:on_quiz/createQuizPage.dart';
import 'package:on_quiz/myquiz.dart';
import 'package:on_quiz/services/databaseConection.dart';
import 'package:on_quiz/startGame.dart';

import 'QuizGame.dart';
import 'editQuizName.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPState();
}

class _ResultPState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
      String newLogin = "";
       String newPhone = "";
       List<String> newCompleteQuizs = [];
       String? newStars;
            DatabaseConection dbCon = DatabaseConection();
dbCon.uid = curUser?.id;
          final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection("users").doc(curUser?.id);
    docRef.get().then((doc) {
       newLogin = doc.data()!["Login"];
        newPhone = doc.data()!["Phone"];
        newStars = doc.data()!["starsCount"].toString();
        newCompleteQuizs = List.from(doc.data()!["completeQuizs"]);
    });

    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: IconButton(
        
        onPressed: () {
                    
newCompleteQuizs.add(activeQuizId!);
    Timer(Duration(seconds: 1), () {
       dbCon.updateUserData(newLogin, newPhone,
                        dbCon.uid.toString(), (quizStars !+  int.parse(newStars!)), newCompleteQuizs);
             
          Navigator.popAndPushNamed(context, '/mainPage');
        });},
        icon: Icon(
          Icons.arrow_back,
          size: MediaQuery.of(context).size.height * 0.06,
          color: Color.fromARGB(255, 207, 217, 255),
        ),
      ),
      backgroundColor: Color.fromARGB(250, 93, 108, 215),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.11)),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (quizStars! > 0
                      ? Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 249, 225, 159),
                          size: MediaQuery.of(context).size.height * 0.10,
                        )
                      : Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 136, 136, 136),
                          size: MediaQuery.of(context).size.height * 0.10,
                        )),
                  (quizStars! > 1
                      ? Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 249, 225, 159),
                          size: MediaQuery.of(context).size.height * 0.13,
                        )
                      : Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 136, 136, 136),
                          size: MediaQuery.of(context).size.height * 0.13,
                        )),
                  (quizStars! > 2
                      ? Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 249, 225, 159),
                          size: MediaQuery.of(context).size.height * 0.10,
                        )
                      : Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 136, 136, 136),
                          size: MediaQuery.of(context).size.height * 0.10,
                        )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01)),
            Text(
              "Вы заработали: " + quizStars.toString() + ((quizStars) == 0 ? " звезд!" : (quizStars) == 1 ? " звезду!" : " звезды!"),
              style: TextStyle(
                color: Colors.white,
                fontFamily: "OpenSans-SemiBold",
                fontSize: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05)),
            Container(
              width: (MediaQuery.of(context).size.width * 0.8),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Color.fromARGB(250, 86, 94, 205),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.045,
                  )),
                  SizedBox(
                    child: Text(
                      activeQuiz.Name!,
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontFamily: "OpenSans-SemiBold",
                      ),
                    ),
                  ),
                  Divider(
                      height: 15,
                      thickness: 2,
                      color: Color.fromARGB(207, 255, 255, 255)),
                  Padding(
                      padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                  )),
                  SizedBox(
                    child: Text(
                      "Автор: " + activeQuiz.UserLogin!,
                      style: TextStyle(
                        fontSize: 19,
                        color: Color.fromARGB(207, 255, 255, 255),
                        fontFamily: "OpenSans-SemiBold",
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      "Категория: " + activeQuiz.Category!,
                      style: TextStyle(
                        fontSize: 19,
                        color: Color.fromARGB(207, 255, 255, 255),
                        fontFamily: "OpenSans-SemiBold",
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      "Количество вопросов: " +
                          activeQuiz.questions.length.toString(),
                      style: TextStyle(
                        fontSize: 19,
                        color: Color.fromARGB(207, 255, 255, 255),
                        fontFamily: "OpenSans-SemiBold",
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      "Сложность: " + activeQuiz.Difficult!,
                      style: TextStyle(
                        fontSize: 19,
                        color: Color.fromARGB(207, 255, 255, 255),
                        fontFamily: "OpenSans-SemiBold",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.13,
            )),
          ],
        ),
      )),
    );
  }
}
