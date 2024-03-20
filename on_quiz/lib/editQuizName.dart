import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_quiz/createQuizPage.dart';
import 'package:on_quiz/quizClass.dart';
import 'package:on_quiz/quizsPage.dart';

import 'myquiz.dart';

class EditQuizName extends StatefulWidget {
  const EditQuizName({super.key});

  @override
  State<EditQuizName> createState() => _EditQuizNameState();
}

const List<String> categoryList = <String>[
  'Наука',
  'Биология',
  'История',
  'Политика',
  'Игры',
  'Аниме',
  'Кино',
  'Спорт',
  'Сериалы',
  'Книги'
];
String? nameQuiz = activeQuiz.Name;
String editCategoryValue = activeQuiz.Category!;
String? loginUser = activeQuiz.UserLogin;

String? countQuestions = activeQuiz.questions.length.toString();
TextEditingController quesEditCountController = new TextEditingController();
TextEditingController nameEditController = new TextEditingController();

class _EditQuizNameState extends State<EditQuizName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton: IconButton(
          onPressed: () => 
                            Navigator.pop(context),
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
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.09,
                )),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01)),
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                )),
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.045,
                )),
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.045,
                )),
                Container(
                  child: SizedBox(
                    width: 300,
                    height: MediaQuery.of(context).size.height * 0.07,
                    // height: MediaQuery.of(context.size.height * 0.05),
                    child: TextField(
                      controller: nameEditController,
                      style: TextStyle(
                          color: Color.fromARGB(250, 250, 250, 250),
                          fontFamily: "OpenSans-SemiBold",
                          fontSize: 22),
                      cursorColor: Color.fromARGB(250, 250, 250, 250),
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
                        hintText: "Название",
                        fillColor: Color.fromARGB(250, 86, 94, 205),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(250, 250, 250, 250),
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                )),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(250, 86, 94, 205)),
                  child: SizedBox(
                      width: 300,
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: DropdownButton<String>(
                          onTap: () {},
                          value: editCategoryValue,
                          isExpanded: true,
                          underline: Container(
                            height: 0,
                            color: Color.fromARGB(250, 86, 94, 205),
                          ),
                          dropdownColor: Color.fromARGB(250, 86, 94, 205),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                          icon: const Icon(Icons.keyboard_arrow_down_sharp,
                              color: Color.fromARGB(255, 58, 40, 167)),
                          iconSize: 50,
                          items: categoryList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(value,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: "OpenSans-SemiBold",
                                    )),
                              ),
                            );
                          }).toList(),
                          elevation: 20,
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              editCategoryValue = value!;
                            });
                          },
                          hint: Container(
                            margin: EdgeInsets.all(10),
                            child: Text("Категория",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: "OpenSans-SemiBold",
                                )),
                          ))),
                ),
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                )),
                Container(
                  child: SizedBox(
                    width: 300,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        // for below version 2 use this
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: quesEditCountController,
                      style: TextStyle(
                          color: Color.fromARGB(250, 250, 250, 250),
                          fontFamily: "OpenSans-SemiBold",
                          fontSize: 22),
                      cursorColor: Color.fromARGB(250, 250, 250, 250),
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
                        hintText: "Количество вопросов",
                        fillColor: Color.fromARGB(250, 86, 94, 205),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(250, 250, 250, 250),
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.10,
                )),
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: IconButton(
                          icon: Icon(Icons.delete),
                          iconSize: MediaQuery.of(context).size.height * 0.1,
                          color: Color.fromARGB(211, 234, 40, 40),
                          onPressed: () {
                            showDialog(barrierDismissible: false,
context: context, builder: (_) => AlertDialog(
                              
                            backgroundColor: Color.fromARGB(250, 86, 94, 205),
                              title: Text(
                                "Осторожно!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "OpenSans-SemiBold",
                                  fontSize: 22,
                                ),
                              ),
                              content: Text(
                                "Вы уверены что хотите удалить викторину?",
                                style: TextStyle(
                                  color: Color.fromARGB(211, 255, 255, 255),
                                  fontFamily: "OpenSans-SemiBold",
                                  fontSize: 19,
                                ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "Нет",
                                    style: TextStyle(
                                      color: Color.fromARGB(211, 234, 40, 40),
                                      fontFamily: "OpenSans-SemiBold",
                                      fontSize: 19,
                                    ),
                                  ),
                                  
                                ),CupertinoDialogAction(
                                                                    onPressed: () {
                                    FirebaseFirestore.instance
                                .collection('quizs')
                                .doc(activeQuizId)
                                .delete();
                            isDelete = true;
                            
                            Navigator.pop(context);
                            Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Да",
                                    style: TextStyle(
                                      color: Color.fromARGB(210, 66, 234, 40),
                                      fontFamily: "OpenSans-SemiBold",
                                      fontSize: 19,
                                    ),
                                  ),
                                  
                                )
                              ],
                            ));
                            
                          }),
                    ),
                    SizedBox(
                      child: IconButton(
                          icon: Icon(Icons.edit),
                          iconSize: MediaQuery.of(context).size.height * 0.25,
                          color: Color.fromARGB(250, 249, 225, 159),
                          onPressed: () {
                            isDelete = false;
                            isEdit = true;
                            if (nameEditController.text != "" &&
                                editCategoryValue != "" &&
                                quesEditCountController.text != "" && nameEditController.text.length < 15) {
                              activeQuiz.Name = nameEditController.text;
                              activeQuiz.Category = editCategoryValue;
                              questionsCount =
                                  int.parse(quesEditCountController.text);
                              if (questionsCount! <
                                  activeQuiz.questions.length) {
                                List<Question> newQues = [];
                                for (int i = 0; i < questionsCount!; i++) {
                                  newQues.add(activeQuiz.questions[i]);
                                }
                                activeQuiz.questions = newQues;
                              } else {
                                while (activeQuiz.questions.length !=
                                    int.parse(countQuestions!)) {
                                  activeQuiz.questions.add(new Question(
                                      discription: "",
                                      answerFour: "",
                                      answerOne: "",
                                      answerThree: "",
                                      answerTwo: "",
                                      correctanswer: ""));
                                }
                              }
                              Navigator.popAndPushNamed(
                                  context, '/createQuestion');
                            }
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
