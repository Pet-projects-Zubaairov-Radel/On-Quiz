import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:on_quiz/authPage.dart';
import 'package:on_quiz/services/databaseConection.dart';
import 'package:on_quiz/services/model.dart';
import 'package:on_quiz/services/services.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => PprofileEditPageState();
}

  String? stars;

class PprofileEditPageState extends State<ProfileEditPage> {
  String ErrorMes = "";
  bool isError = false;
  DbConnection dbConnection = DbConnection();
  DatabaseConection dbCon = DatabaseConection();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final ProfileLoginController = TextEditingController();
  final ProfilePhoneController = TextEditingController();

  @override
  void dispose() {
    ProfileLoginController.dispose();
    ProfilePhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        final DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection("users").doc(curUser?.id);
        List<String>? newCompleteQuizs;
    docRef.get().then((doc) {
      ProfileLoginController.text = doc.data()!["Login"];
      ProfilePhoneController.text = doc.data()!["Phone"];
        newCompleteQuizs = List.from(doc.data()!["completeQuizs"]);
    });
    
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 249, 225, 159),
            size: MediaQuery.of(context).size.height * 0.15,
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02)),
          Text(
            "У вас: " + stars! + " звезд!",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "OpenSans-SemiBold",
              fontSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02)),
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
                  top: MediaQuery.of(context).size.height * 0.02)),
          Container(
            child: SizedBox(
              width: 246,
              height: MediaQuery.of(context).size.height * 0.06,
              child: TextField(
                style: TextStyle(
                    color: Color.fromARGB(200, 40, 49, 73),
                    fontFamily: "OpenSans-SemiBold",
                    fontSize: 22),
                controller: ProfileLoginController,
                cursorColor: Color.fromARGB(6, 160, 160, 160),
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
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03)),
          Container(
            child: SizedBox(
              width: 246,
              height: MediaQuery.of(context).size.height * 0.06,
              child: TextField(
                controller: ProfilePhoneController,
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
                        width: 0, color: Color.fromARGB(250, 93, 108, 215)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        width: 0, color: Color.fromARGB(250, 93, 108, 215)),
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
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03)),
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1)),
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
                      id: querySnapshot.docs[i].get('id')));
                }
                if (ProfilePhoneController.text != "" && ProfileLoginController.text != "") {
                  if (newUsers
                          .where((element) => element.Login == ProfileLoginController.text)
                          .length ==
                      0) {
                    userLogin = ProfileLoginController.text;
                    dbCon.uid = curUser?.id;
                    dbCon.updateUserData(ProfileLoginController.text, ProfilePhoneController.text,
                        dbCon.uid.toString(), int.parse(stars!), newCompleteQuizs!);
                  } else {
                    setState(() {
                      ErrorMes = "Пользователь с таким логином уже существует";
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
                "Сохранить",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "OpenSans-SemiBold",
                    fontSize: 18),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 58, 40, 167)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ))),
            ),
            height: MediaQuery.of(context).size.height * 0.045,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ],
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
