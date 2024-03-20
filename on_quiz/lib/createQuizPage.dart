import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_quiz/authPage.dart';
import 'package:on_quiz/quizClass.dart';

import 'createQuestion.dart';

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

const List<String> complexityList = <String>['Легкая', 'Средняя', 'Сложная'];

final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('Users');

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _MyWidgetState();
}

String? categoryValue = null;
String? complexity = null;
CollectionReference users = FirebaseFirestore.instance.collection('users');

class _MyWidgetState extends State<CreateQuizPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController quesCountController = new TextEditingController();
    TextEditingController nameController = new TextEditingController();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.001)),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(250, 86, 94, 205)),
            child: SizedBox(
                width: 300,
                height: MediaQuery.of(context).size.height * 0.065,
                child: DropdownButton<String>(
                    onTap: () {},
                    value: categoryValue,
                    isExpanded: true,
                    underline: Container(
                      height: 0,
                      color: Color.fromARGB(250, 86, 94, 205),
                    ),
                    dropdownColor: Color.fromARGB(250, 86, 94, 205),
                    style: const TextStyle(color: Colors.white, fontSize: 22),
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
                        categoryValue = value!;
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
            top: MediaQuery.of(context).size.height * 0.03,
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
                    value: complexity,
                    isExpanded: true,
                    underline: Container(
                      height: 0,
                      color: Color.fromARGB(250, 86, 94, 205),
                    ),
                    dropdownColor: Color.fromARGB(250, 86, 94, 205),
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                    icon: const Icon(Icons.keyboard_arrow_down_sharp,
                        color: Color.fromARGB(255, 58, 40, 167)),
                    iconSize: 50,
                    items: complexityList
                        .map<DropdownMenuItem<String>>((String index) {
                      return DropdownMenuItem<String>(
                        value: index,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(index,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: "OpenSans-SemiBold",
                              )),
                        ),
                      );
                    }).toList(),
                    elevation: 20,
                    onChanged: (String? index) {
                      String nameQuiz = nameController.text;
                      String count = quesCountController.text;
                      setState(() {
                        complexity = index!;
                      });
                      nameController.text = nameQuiz;
                      quesCountController.text = count;
                    },
                    hint: Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Сложность",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: "OpenSans-SemiBold",
                          )),
                    ))),
          ),
          Padding(
              padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.03,
          )),
          Container(
            child: SizedBox(
              width: 300,
              height: MediaQuery.of(context).size.height * 0.07,
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Zа-яА-Я ]')),
                ],
                controller: nameController,
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
                        width: 0, color: Color.fromARGB(250, 93, 108, 215)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        width: 0, color: Color.fromARGB(250, 93, 108, 215)),
                  ),
                  filled: true,
                  hintText: "Название викторины",
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
                  top: MediaQuery.of(context).size.height * 0.03)),
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
                controller: quesCountController,
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
                        width: 0, color: Color.fromARGB(250, 93, 108, 215)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        width: 0, color: Color.fromARGB(250, 93, 108, 215)),
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
            top: MediaQuery.of(context).size.height * 0.07,
          )),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Color.fromARGB(250, 132, 199, 110),
                  width: 5,
                ),
                color: Color.fromARGB(250, 93, 108, 215)),
            child: SizedBox(
              child: IconButton(
                icon: Icon(Icons.arrow_forward),
                iconSize: MediaQuery.of(context).size.height * 0.1,
                color: Color.fromARGB(250, 132, 199, 110),
                onPressed: () async {
                  String? Login = userLogin;

                  if (categoryValue != null &&
                      complexity != null &&
                      nameController.text != "" && nameController.text.length < 15) {
                    questionsCount = int.parse(quesCountController.text);
                    activeQuiz = new Quiz(
                        UserLogin: Login,
                        Category: categoryValue,
                        Name: nameController.text,
                        Difficult: complexity, UserId: curUser?.id);
                    activeQuiz.questions.add(new Question(
                        discription: "",
                        answerFour: "",
                        answerOne: "",
                        answerThree: "",
                        answerTwo: "",
                        correctanswer: ""));
                    quesIndex = 0;
                    discriptionController.text =
                        activeQuiz.questions[quesIndex].discription.toString();
                    FirstAnswerController.text =
                        activeQuiz.questions[quesIndex].answerOne.toString();
                    SecondAnswerController.text =
                        activeQuiz.questions[quesIndex].answerTwo.toString();
                    ThreeAnswerController.text =
                        activeQuiz.questions[quesIndex].answerThree.toString();
                    FourAnswerController.text =
                        activeQuiz.questions[quesIndex].answerFour.toString();
                    CorrectAnswerController = (activeQuiz
                                .questions[quesIndex].correctanswer
                                .toString() ==
                            activeQuiz.questions[quesIndex].answerOne.toString()
                        ? answersList[0]
                        : activeQuiz.questions[quesIndex].correctanswer
                                    .toString() ==
                                activeQuiz.questions[quesIndex].answerTwo
                                    .toString()
                            ? answersList[1]
                            : activeQuiz.questions[quesIndex].correctanswer
                                        .toString() ==
                                    activeQuiz.questions[quesIndex].answerThree
                                        .toString()
                                ? answersList[2]
                                : answersList[3]);
                                isEdit = false;
                    Navigator.pushNamed(context, "/createQuestion");

                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
bool isEdit  = false;
int quesIndex = 0;
int? questionsCount;
Quiz activeQuiz =
    new Quiz(UserLogin: "", Category: "", Name: "", Difficult: "", UserId: curUser?.id);
