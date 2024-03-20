import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:on_quiz/myquiz.dart';
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
  int selectedIndex = 0;
  String searchText = "";

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
 onItemSearch(String value) {
    setState(
      () {
        searchText = value;

        // return newDealList
        //     .where(
        //       (element) => element.title!.contains(value),
        //     )
        //     .toList();
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
    Icon icon = new Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 249, 225, 159),
                                    size: 35,
                                  ) ;
    Widget listSearchWidget(BuildContext context) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('quizs').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data?.docs.length == 0 || !snapshot.hasData) {
            return Text(
              "Нет Записей",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "IMFellGreatPrimerSC-Regular",
                  fontSize: 20),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                Card card = new  Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 86, 94, 205),
                  )),
              color: Color.fromARGB(255, 86, 94, 205),
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
                                child: 
                                  (snapshot.data?.docs[index].get('difficult')!  == "Легкая"? 
                                  icon : (snapshot.data?.docs[index].get('difficult')!  == "Средняя" ? (Row(children: [icon, icon],)
                                   ): Row(children: [icon, icon, icon]) ))
                              
                              ))
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
      automaticallyImplyLeading: true,
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
      automaticallyImplyLeading: true,
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
      automaticallyImplyLeading: true,
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
    );
    return Scaffold(

        //drawer:const MenuDrawer(),
        backgroundColor: Color.fromARGB(250, 93, 108, 215),
        appBar: selectedIndex == 0
            ? (tittleAppBar ? appBarSearch : appBar)
            : deffaultAppBar,
        body: Center(
          child: list.elementAt(selectedIndex),
        ),
        bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: BottomNavigationBar(
                onTap: onItemTap,
                backgroundColor: (Color.fromARGB(255, 58, 40, 167)),
                unselectedItemColor: Color.fromARGB(255, 145, 135, 206),
                selectedItemColor: Color.fromARGB(255, 207, 217, 255),
                selectedLabelStyle: TextStyle(
                    color: Color.fromARGB(255, 207, 217, 255),
                    fontFamily: "OpenSans-SemiBold",
                    fontSize: MediaQuery.of(context).size.height * 0.014),
                unselectedLabelStyle: TextStyle(
                    color: Color.fromARGB(255, 207, 217, 255),
                    fontFamily: "OpenSans-SemiBold",
                    fontSize: MediaQuery.of(context).size.height * 0.011),
                showUnselectedLabels: true,
                currentIndex: selectedIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people_outline_outlined, size: 35),
                    label: 'Онлайн викторины',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add,
                      size: 35,
                    ),
                    label: 'Создать викторину',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_outlined, size: 35),
                    label: 'Мои викторины',
                  ),
                ],
              ),
            )));
  }
}
