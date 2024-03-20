import 'package:flutter/material.dart';

class QuizsPage extends StatelessWidget {
  const QuizsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Card quizCard = new  Card(
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
                              "Название",
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
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 249, 225, 159),
                                    size: 35,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 249, 225, 159),
                                    size: 35,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 249, 225, 159),
                                    size: 35,
                                  ),
                                ],
                              )))
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Пользователь",
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
                              "Категория",
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
    return ListView(
           
      children: [quizCard, quizCard, quizCard,quizCard,quizCard, quizCard, quizCard,quizCard ],
    );
  }
}
