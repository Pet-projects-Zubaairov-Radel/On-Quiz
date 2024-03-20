import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseConection{
  String? uid;

  DatabaseConection({this.uid});

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String login, String phone, String id, int starsCount, List<String> completeQuizs) async{
    return await users.doc(uid).set({
      'Login': login,
      'Phone' : phone,
      'id' : id,
      'starsCount' : starsCount,
      'completeQuizs': completeQuizs,
    });
  
  }

}