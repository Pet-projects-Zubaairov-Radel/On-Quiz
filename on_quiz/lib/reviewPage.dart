import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_quiz/authPage.dart';
import 'package:on_quiz/createQuizPage.dart';
import 'package:on_quiz/myquiz.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

String? nameQuiz;

String? loginUser;

String? countQuestions;

TextEditingController discriptionController = TextEditingController();

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    nameQuiz = activeQuiz.Name;

    loginUser = activeQuiz.UserLogin;

    countQuestions = activeQuiz.questions.length.toString();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: IconButton(
        onPressed: () => Navigator.popAndPushNamed(context, '/mainPage'),
        icon: Icon(
          Icons.arrow_back,
          size: MediaQuery.of(context).size.height * 0.06,
          color: Color.fromARGB(255, 207, 217, 255),
        ),
      ),
      backgroundColor: Color.fromARGB(250, 93, 108, 215),
      body: SingleChildScrollView(
        child: Center(
            child: Column(children: <Widget>[
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
                    nameQuiz!,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontFamily: "OpenSans-SemiBold",
                    ),
                  ),
                ),
                Divider(
                    height: 17,
                    thickness: 2,
                    color: Color.fromARGB(207, 255, 255, 255)),
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                )),
                SizedBox(
                  child: Text(
                    "Автор: " + loginUser!,
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
                    "Количество вопросов: " + countQuestions!,
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
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                )),
              ],
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
          SizedBox(
            child: Divider(
                height: 4,
                thickness: 4,
                color: Color.fromARGB(207, 255, 255, 255)),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 1),
            height: MediaQuery.of(context).size.height * 0.24,
            color: Color.fromARGB(250, 86, 94, 205),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.record_voice_over_sharp),
                    title: Row(
                      children: [
                        Text(
                          userLogin,
                          style: TextStyle(
                            color: Color.fromARGB(172, 0, 0, 0),
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 22,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (discriptionController.text != "") {
                                FirebaseFirestore.instance
                                    .collection('reviews')
                                    .add({
                                  'discription': discriptionController.text,
                                  'quizId': activeQuizId,
                                  'userLogin': userLogin
                                });
                              }
                            },
                            icon: Icon(Icons.send))
                      ],
                    ),
                    subtitle: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 3,
                      controller: discriptionController,
                      style: TextStyle(
                        color: Color.fromARGB(120, 0, 0, 0),
                        fontFamily: "OpenSans-SemiBold",
                        fontSize: 22,
                      ),
                      cursorColor: Color.fromARGB(120, 0, 0, 0),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.white),
                        ),
                        filled: true,
                        hintText: "Отзыв",
                        fillColor: Color.fromARGB(249, 255, 255, 255),
                        hintStyle: TextStyle(
                            color: Color.fromARGB(120, 0, 0, 0),
                            fontFamily: "OpenSans-SemiBold",
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: (MediaQuery.of(context).size.width * 1),
              height: MediaQuery.of(context).size.height * 0.5,
              color: Color.fromARGB(250, 86, 94, 205),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('reviews')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  bool fd = snapshot.data?.docs
                          .where((element) =>
                              element.get('quizId') == activeQuizId)
                          .length ==
                      0;
                  if (snapshot.data?.docs.length == 0 ||
                      !snapshot.hasData ||
                      fd) {
                    return Text(
                      textAlign: TextAlign.center,
                      "Нет отзывов",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "OpenSans-SemiBold",
                        fontSize: 24,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Card card = Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.record_voice_over_sharp),
                                title: Text(
                                  snapshot.data?.docs[index].get('userLogin'),
                                  style: TextStyle(
                                    color: Color.fromARGB(172, 0, 0, 0),
                                    fontFamily: "OpenSans-SemiBold",
                                    fontSize: 22,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data?.docs[index].get('discription'),
                                  style: TextStyle(
                                    color: Color.fromARGB(138, 0, 0, 0),
                                    fontFamily: "OpenSans-SemiBold",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        );
                        if (activeQuizId ==
                            snapshot.data?.docs[index].get('quizId')) {
                          return card;
                        } else {
                          return Card();
                        }
                      },
                    );
                  }
                },
              )

              //  ListView(children: <Widget>[

              //   Card(
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: <Widget>[

              //         const ListTile(
              //           leading: Icon(Icons.record_voice_over_sharp),
              //           title: Text('The Enchanted Nightingale'),
              //           subtitle: Text(
              //               'Music by Julie Gable. Lyrics by Sidney Stein.\nedfsdfsudfbusdfbisdbfidsygb\nedfsdfsudfbusdfbisdbfidsygb\nedfsdfsudfbusdfbisdbfidsygb'),
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: <Widget>[
              //             const SizedBox(width: 8),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ])
              ),
        ])),
      ),
    );
  }
}
