import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:on_quiz/profileEditPage.dart';

import 'authPage.dart';

class MultiplayerPage extends StatefulWidget {
  const MultiplayerPage({super.key});

  @override
  State<MultiplayerPage> createState() => MmultiplayerPageState();
}

class MmultiplayerPageState extends State<MultiplayerPage> {
  int multiplayerSelectedIndex = 0;
  String searchText = "";

  void onItemTap(int index) {
    setState(() {
      multiplayerSelectedIndex = index;
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
    "Рейтинг",
    "Профиль",
  ];

  bool tittleAppBar = false;
  @override
  Widget build(BuildContext context) {
    Icon icon = new Icon(
      Icons.star,
      color: Color.fromARGB(255, 249, 225, 159),
      size: 35,
    );
    Widget listSearchWidget(BuildContext context) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('starsCount', descending: true)
            .snapshots(),
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
                  onTap: () async {},
                  child: new Card(
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
                                    snapshot.data?.docs[index].get('Login'),
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
                                    child: Row(
                                      children: [
                                        Text(
                                          (snapshot.data?.docs[index]
                                              .get('starsCount')).toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "OpenSans-SemiBold",
                                            fontSize: 22,
                                          ),
                                        ),
                                        icon
                                      ],
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
                String newStr = snapshot.data?.docs[index].get('Login');
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

    final list = [listSearchWidget(context), const ProfileEditPage()];
    AppBar deffaultAppBar = AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(
        color: Color.fromARGB(250, 153, 144, 210), //change your color here
      ),
      backgroundColor: Color.fromARGB(255, 58, 40, 167),
      title: Text(
        title[multiplayerSelectedIndex],
        style: TextStyle(
            color: Color.fromARGB(250, 153, 144, 210),
            fontFamily: "OpenSans-SemiBold",
            fontSize: 22),
      ),
      centerTitle: true,
    );
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
          hintText: "Никнейм",
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
        title[multiplayerSelectedIndex],
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
    final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection("users").doc(curUser?.id);
    docRef.get().then((doc) {
      stars = doc.data()!["starsCount"].toString();
    });
    return Scaffold(
        backgroundColor: Color.fromARGB(250, 93, 108, 215),
        appBar: multiplayerSelectedIndex == 0
            ? (tittleAppBar ? appBarSearch : appBar)
            : deffaultAppBar,
        body: Center(
          child: list.elementAt(multiplayerSelectedIndex),
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
                left: MediaQuery.of(context).size.width * 0.15,
                right: MediaQuery.of(context).size.width * 0.15),
            tabs: [
              GButton(
                onPressed: () {
                  setState(() {
                    multiplayerSelectedIndex = 0;
                  });
                },
                icon: Icons.people_alt_outlined,
                text: 'Игроки',
              ),
              GButton(
                onPressed: () {
                  setState(() {
                    multiplayerSelectedIndex = 1;
                  });
                },
                icon: Icons.person_outline_outlined,
                text: 'Профиль',
              ),
            ]));
  }
}
