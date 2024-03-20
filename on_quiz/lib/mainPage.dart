import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:on_quiz/authPage.dart';
import 'package:on_quiz/multiplayerPage.dart';
import 'package:on_quiz/myquiz.dart';
import 'package:on_quiz/quizClass.dart';
import 'package:on_quiz/resultPage.dart';
import 'package:on_quiz/services/services.dart';
import 'QuizGame.dart';
import 'quizsPage.dart';
import 'createQuizPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => StateMainPage();
}

class StateMainPage extends State<MainPage> {
  int selectedIndex = 1;
  String searchText = "";
List<String> newCompleteQuizs = [];
          final DocumentReference<Map<String, dynamic>> docRef =
              FirebaseFirestore.instance.collection("users").doc(curUser?.id);

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  onItemSearch(String value) {
    setState(
      () {
        searchText = value;
      },
    );
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

  TextEditingController searchController = TextEditingController();
  final title = [
    "Викторины",
    "Создание", // 1
    "Мои викторины"
  ];
  bool tittleAppBar = false;
  @override
  Widget build(BuildContext context) {

    DbConnection as = DbConnection();
    Icon icon = new Icon(
      Icons.star,
      color: Color.fromARGB(255, 249, 225, 159),
      size: 35,
    );
    Widget listSearchWidget(BuildContext context) {
                             docRef.get().then((doc) {
            newCompleteQuizs = List.from(doc.data()!["completeQuizs"]);
          });
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('quizs').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.data?.docs.length == 0 || !snapshot.hasData) {
            return Text(
              "Нет записей",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "OpenSans-SemiBold",
                fontSize: 22,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                GestureDetector card = GestureDetector(
                  
                  onTap: () async {
                    activeQuiz = new Quiz(
                          Category: snapshot.data?.docs[index].get('category'),
                          Difficult:
                              snapshot.data?.docs[index].get('difficult'),
                          Name: snapshot.data?.docs[index].get('name'),
                          UserLogin:
                              snapshot.data?.docs[index].get('userLogin'),
                          UserId: curUser?.id);
                      List<Question> quess = [];
                      List<dynamic> sdf =
                          snapshot.data?.docs[index].get('questions');
                      final List<Map<String, dynamic>> fooData =
                          List.from(sdf.where((x) => x is Map));
                      for (var element in fooData) {
                        quess.add(Question(
                            discription: element['discription'],
                            answerFour: element['answerFour'],
                            answerOne: element['answerOne'],
                            answerThree: element['answerThree'],
                            answerTwo: element['answerTwo'],
                            correctanswer: element['correctanswer']));
                      }
                      activeQuizId = snapshot.data?.docs[index].id;
                      activeQuiz.questions = quess;
                    if (newCompleteQuizs.contains(
                        activeQuizId = snapshot.data?.docs[index].id) ||snapshot.data?.docs[index].get('userId') ==
                        curUser!.id ) {
                          Navigator.popAndPushNamed(context, '/reviewPage');
                    } else {
                      quesIndex = 0;
                      
                      Navigator.popAndPushNamed(context, '/startgame').then((value) {
                        btnColors = [
                          Color.fromARGB(250, 86, 94, 205),
                          Color.fromARGB(250, 86, 94, 205),
                          Color.fromARGB(250, 86, 94, 205),
                          Color.fromARGB(250, 86, 94, 205)
                        ];
                        indexColor = 0;
                      });
                    }
                  },
                  child: new Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 86, 94, 205),
                        )),
                    color: newCompleteQuizs.contains(
                        activeQuizId = snapshot.data?.docs[index].id )  || snapshot.data?.docs[index].get('userId') ==
                        curUser!.id ?Color.fromARGB(255, 103, 165, 87) :  Color.fromARGB(255, 86, 94, 205),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    snapshot.data?.docs[index].get('name'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "OpenSans-SemiBold",
                                      fontSize: 22,
                                    ),
                                  ),
                                )),
                            Spacer(),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: (snapshot.data?.docs[index]
                                                .get('difficult')! ==
                                            "Легкая"
                                        ? icon
                                        : (snapshot.data?.docs[index]
                                                    .get('difficult')! ==
                                                "Средняя"
                                            ? (Row(
                                                children: [icon, icon],
                                              ))
                                            : Row(children: [
                                                icon,
                                                icon,
                                                icon
                                              ])))))
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    snapshot.data?.docs[index].get('userLogin'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "OpenSans-SemiBold",
                                      fontSize: 22,
                                    ),
                                  ),
                                )),
                            Spacer(),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    snapshot.data?.docs[index].get('category'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "OpenSans-SemiBold",
                                      fontSize: 22,
                                    ),
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
                String newStr = snapshot.data?.docs[index].get('name');
                if (tittleAppBar) {
                  if (newStr.contains(searchText)) {
                    return card;
                  }
                } else {
                  return card;
                }
                return Card();
              },
            );
          }
        },
      );
    }

    final list = [
      listSearchWidget(context),
      const CreateQuizPage(),
      const MyQuizPage(),
    ];
    AppBar appBarSearch = AppBar(
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 145, 135, 206), //change your color here
      ),
      backgroundColor: (Color.fromARGB(255, 58, 40, 167)),
      centerTitle: true,
      title: TextField(
        style: TextStyle(
            color: Color.fromARGB(250, 153, 144, 210),
            fontFamily: "OpenSans-SemiBold",
            fontSize: 22),
        cursorColor: Color.fromARGB(250, 153, 144, 210),
        decoration: const InputDecoration(
          hintStyle: TextStyle(
              color: Color.fromARGB(250, 153, 144, 210),
              fontFamily: "OpenSans-SemiBold",
              fontSize: 22),
          hintText: "Название",
        ),
        controller: searchController,
        onChanged: onItemSearch,
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                searchController.clear();
                tittleAppBar = false;
              });
            },
            icon: const Icon(Icons.close))
      ],
    );
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 145, 135, 206), //change your color here
      ),
      backgroundColor: (Color.fromARGB(255, 58, 40, 167)),
      title: Text(
        title[selectedIndex],
        style: TextStyle(
            color: Color.fromARGB(250, 153, 144, 210),
            fontFamily: "OpenSans-SemiBold",
            fontSize: 22),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                tittleAppBar = true;
              });
            },
            icon: const Icon(
              Icons.search_outlined,
              size: 30,
            ))
      ],
    );
    AppBar deffaultAppBar = AppBar(
      automaticallyImplyLeading: selectedIndex == 2,
      leading: IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          as.logOut();

          Navigator.popAndPushNamed(context, '/');
        },
      ),
      iconTheme: IconThemeData(
        color: Color.fromARGB(250, 153, 144, 210), //change your color here
      ),
      backgroundColor: Color.fromARGB(255, 58, 40, 167),
      title: Text(
        title[selectedIndex],
        style: TextStyle(
            color: Color.fromARGB(250, 153, 144, 210),
            fontFamily: "OpenSans-SemiBold",
            fontSize: 22),
      ),
      centerTitle: true,
      actions: [
        selectedIndex == 2
            ? IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/multiplayerPage');
                },
                icon: const Icon(
                  Icons.cloud_circle_outlined,
                  size: 30,
                ))
            : const Icon(null)
      ],
    );
    return Scaffold(
        backgroundColor: Color.fromARGB(250, 93, 108, 215),
        appBar: selectedIndex == 0
            ? (tittleAppBar ? appBarSearch : appBar)
            : deffaultAppBar,
        body: Center(
          child: list.elementAt(selectedIndex),
        ),
        bottomNavigationBar: GNav(
            backgroundColor: (Color.fromARGB(255, 58, 40, 167)),
            duration: Duration(milliseconds: 900), // tab animation duration
            gap: 4, // the tab button gap between icon and text
            iconSize: MediaQuery.of(context).size.height *
                0.045, // tab button icon size
            color: Color.fromARGB(255, 145, 135, 206),
            activeColor: Color.fromARGB(255, 207, 217, 255),
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.015,
                bottom: MediaQuery.of(context).size.height * 0.015,
                left: MediaQuery.of(context).size.width * 0.075,
                right: MediaQuery.of(context).size.width * 0.075),
            tabs: [
              GButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                icon: Icons.add,
                text: 'Создание',
              ),
              GButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },                icon: Icons.quiz_outlined,
                text: 'Онлайн',

              ),
              GButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                icon: Icons.person_outline_outlined,
                text: 'Свои',
              ),
            ]));
  }
}
