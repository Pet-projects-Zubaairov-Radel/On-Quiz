import 'package:flutter/material.dart';

class Quiz {
  String? Name;
  String? UserLogin;
  String? Category;
    String? Difficult;
  List<Question> questions = [];
  Quiz({this.Name, this.UserLogin, this.Category, this.Difficult});
}

class Question{
    String? discription;
    String? answerOne;
    String? answerTwo;
    String? answerThree;
    String? answerFour;
    String? correctanswer;
    
    Question({this.discription, this.answerOne, this.answerTwo, this.answerThree, this.answerFour, this.correctanswer});

 Map<String, dynamic> toMap() {
    return {
      'discription': discription,
      'answerOne': answerOne,
      'answerTwo':answerTwo,
            'answerThree': answerThree,
      'answerFour': answerFour,
      'correctanswer':correctanswer,
    };
  }
}