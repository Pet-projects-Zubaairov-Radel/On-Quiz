import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:on_quiz/createQuizPage.dart';
import 'package:on_quiz/startGame.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _MyWidgetState();
}

bool canEdit = true;
List<Color> colors = [
  Color.fromARGB(250, 86, 94, 205),
  Color.fromARGB(211, 234, 40, 40),
  Color.fromARGB(210, 66, 234, 40)
];
List<Color> btnColors = [
  Color.fromARGB(250, 86, 94, 205),
  Color.fromARGB(250, 86, 94, 205),
  Color.fromARGB(250, 86, 94, 205),
  Color.fromARGB(250, 86, 94, 205)
];
int indexColor = 0;

class _MyWidgetState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    void checkColor(int num) {
      setState(() {
        indexColor = num;
      });
    }

    bool isCorrrect(String value) {
      if (activeQuiz.questions[quesIndex].correctanswer.toString() ==
          activeQuiz.questions[quesIndex].answerOne.toString()) {
        btnColors[0] = colors[2];
      } else if (activeQuiz.questions[quesIndex].correctanswer.toString() ==
          activeQuiz.questions[quesIndex].answerTwo.toString()) {
        btnColors[1] = colors[2];
      } else if (activeQuiz.questions[quesIndex].correctanswer.toString() ==
          activeQuiz.questions[quesIndex].answerThree.toString()) {
        btnColors[2] = colors[2];
      } else if (activeQuiz.questions[quesIndex].correctanswer.toString() ==
          activeQuiz.questions[quesIndex].answerFour.toString()) {
        btnColors[3] = colors[2];
      }
      if (value == activeQuiz.questions[quesIndex].correctanswer.toString()) {
        checkColor(2);
        return true;
      } else {
        quizStars = quizStars! - 1;
        if (quizStars == 0) {
          quizStars = 0;
        }
        checkColor(1);
        return false;
      }
    }

    void goNext() {
      canEdit = false;
      Timer(Duration(seconds: 2), () {
bool isEnd = false;
                          if (quesIndex == activeQuiz.questions.length - 1) {
isEnd = true;
          } else {
            quesIndex++;
          }
         setState(() {
          btnColors = [
            Color.fromARGB(250, 86, 94, 205),
            Color.fromARGB(250, 86, 94, 205),
            Color.fromARGB(250, 86, 94, 205),
            Color.fromARGB(250, 86, 94, 205)
          ];
          indexColor = 0;
          canEdit = true;
        });       
                    if (isEnd  || quizStars == 0) {
                      
            Navigator.popAndPushNamed(context, '/resultpage');
          }
       
      });
    }

    return Scaffold(
        backgroundColor: Color.fromARGB(250, 93, 108, 215),
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.04,
            )),
            Text(
              "Вопрос " + (quesIndex + 1).toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "OpenSans-SemiBold",
                  fontSize: 22),
            ), 
            Padding(
                padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
            )),
            SizedBox(
              width: 350,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(250, 86, 94, 205),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                alignment: Alignment.center,
                child: Text(
                  activeQuiz.questions[quesIndex].discription.toString(),
                  maxLines: 4,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "OpenSans-SemiBold",
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                          if (isCorrrect(activeQuiz
                              .questions[quesIndex].answerOne
                              .toString())) {
                          }
                          setState(() {
                            btnColors[0] = colors[indexColor];
                          });
                          goNext();
                        
                      },
                      child: Text(
                        activeQuiz.questions[quesIndex].answerOne.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(btnColors[0]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                    ),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: 300,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  )),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                          if (isCorrrect(activeQuiz
                              .questions[quesIndex].answerTwo
                              .toString())) {}
                          setState(() {
                            btnColors[1] = colors[indexColor];
                          });
                          goNext();
                        
                      },
                      child: Text(
                        activeQuiz.questions[quesIndex].answerTwo.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(btnColors[1]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                    ),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: 300,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  )),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                          if (isCorrrect(activeQuiz
                              .questions[quesIndex].answerThree
                              .toString())) {}
                          setState(() {
                            btnColors[2] = colors[indexColor];
                          });
                          goNext();
                        
                      },
                      child: Text(
                        activeQuiz.questions[quesIndex].answerThree.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(btnColors[2]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                    ),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: 300,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  )),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                          if (isCorrrect(activeQuiz
                              .questions[quesIndex].answerFour
                              .toString())) {}
                          setState(() {
                            btnColors[3] = colors[indexColor];
                          });
                          goNext();
                        
                      },
                      child: Text(
                        activeQuiz.questions[quesIndex].answerFour.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(btnColors[3]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                    ),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: 300,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  )),
                ],
              ),
            ),
          ])),
        ));
  }
}
