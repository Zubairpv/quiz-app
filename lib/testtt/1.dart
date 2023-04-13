import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz/home.dart';

class IndexNotifier extends ChangeNotifier {
  bool answerWasSelected = false;
  bool endQuiz = false;
  int _currentIndex = 0;
  int totalScore = 0;
  bool updateContainer1 = true;
  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }


  void navigateToqstnAnsPage(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: Home(),
        isIos: true,
        duration: Duration(milliseconds: 600),
     ),
);
}
}
