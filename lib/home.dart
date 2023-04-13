import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/answer.dart';
import 'package:quiz/testtt/1.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int questionindex = 1;
  int totalscore = 0;
  bool? answerwasselected = false;
  final List<Icon> _scoretracker = [];

  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<IndexNotifier>(context);
    ResetQuiz() {
      indexProvider.totalScore = 0;
      indexProvider.endQuiz = false;
      indexProvider.currentIndex = 0;
    }

    void AnswerClicked(bool userScore) {
      setState(() {
        indexProvider.answerWasSelected = true;

        if (userScore) {
          indexProvider.totalScore++;
        }
        if (indexProvider.currentIndex + 1 == _questions.length) {
          indexProvider.endQuiz = true;
        }
      });
    }

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Quiz Mentor',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Container(
                height: 800,
                width: 400,
                color: Colors.white,
              ),
              Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (indexProvider.endQuiz == false)
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                elevation: MaterialStateProperty.all(0)),
                            onPressed: () {
                              if (indexProvider.currentIndex <= 0) {
                                return;
                              }
                              indexProvider.currentIndex =
                                  (indexProvider.currentIndex - 1) %
                                      _questions.length;
                            },
                            child: Row(children: [
                              Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.black,
                              ),
                              Text(
                                'Back',
                                style: GoogleFonts.oswald(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ]),
                          ),
                        SizedBox(
                          width: 180,
                          child: Center(
                              child: Text(
                            '${indexProvider.currentIndex + 1}/${_questions.length}',
                            style: GoogleFonts.robotoMono(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all(0)),
                          onPressed: () {
                            indexProvider.currentIndex++;
                            indexProvider.answerWasSelected = false;
                            if (indexProvider.currentIndex >=
                                _questions.length) {
                              ResetQuiz();
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                indexProvider.endQuiz ? 'Restart' : 'Next',
                                style: GoogleFonts.robotoMono(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 130,
                      margin: EdgeInsets.only(left: 30, bottom: 10, right: 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        '${_questions[indexProvider.currentIndex]['question']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    ...(_questions[indexProvider.currentIndex]['answers']
                            as List<Map<String, dynamic>>)
                        .map(
                      (Answer) => Answer1(
                        AnswerText: '${Answer['answerText']}',
                        Answercolor: indexProvider.answerWasSelected
                            ? Answer['score']
                                ? Colors.green
                                : Colors.red
                            : Colors.white,
                        ontap: () {
                          if (indexProvider.answerWasSelected) {
                            return;
                          }
                          AnswerClicked(Answer['score']);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all(0)),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 180,
                        decoration: BoxDecoration(
                            color: null,
                            border: Border.all(color: Colors.blue, width: 3),
                            borderRadius: BorderRadius.circular(40)),
                        child: Center(
                          child: Text(
                            indexProvider.endQuiz
                                ? 'Click Here'
                                : 'Score = ${indexProvider.totalScore}/ ${_questions.length}',
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

// ignore: unused_element
final _questions = [
  {
    'question': 'How long is New Zealand\'s Ninety Mile Beach?',
    'answers': [
      {'answerText': '88km, so 55 miles long.', 'score': true},
      {'answerText': '55km, so 34 miles long.', 'score': false},
      {'answerText': '90km, so 56 miles long.', 'score': false},
    ],
  },
  {
    'question':
        'In which month does the German festival of Oktoberfest mostly take place?',
    'answers': [
      {'answerText': 'January', 'score': false},
      {'answerText': 'October', 'score': false},
      {'answerText': 'September', 'score': true},
    ],
  },
  {
    'question': 'Who composed the music for Sonic the Hedgehog 3?',
    'answers': [
      {'answerText': 'Britney Spears', 'score': false},
      {'answerText': 'Timbaland', 'score': false},
      {'answerText': 'Michael Jackson', 'score': true},
    ],
  },
  {
    'question': 'In Georgia (the state), it’s illegal to eat what with a fork?',
    'answers': [
      {'answerText': 'Hamburgers', 'score': false},
      {'answerText': 'Fried chicken', 'score': true},
      {'answerText': 'Pizza', 'score': false},
    ],
  },
  {
    'question':
        'Which part of his body did musician Gene Simmons from Kiss insure for one million dollars?',
    'answers': [
      {'answerText': 'His tongue', 'score': true},
      {'answerText': 'His leg', 'score': false},
      {'answerText': 'His butt', 'score': false},
    ],
  },
  {
    'question': 'In which country are Panama hats made?',
    'answers': [
      {'answerText': 'Ecuador', 'score': true},
      {'answerText': 'Panama (duh)', 'score': false},
      {'answerText': 'Portugal', 'score': false},
    ],
  },
  {
    'question': 'From which country do French fries originate?',
    'answers': [
      {'answerText': 'Belgium', 'score': true},
      {'answerText': 'France (duh)', 'score': false},
      {'answerText': 'Switzerland', 'score': false},
    ],
  },
  {
    'question': 'Which sea creature has three hearts?',
    'answers': [
      {'answerText': 'Great White Sharks', 'score': false},
      {'answerText': 'Killer Whales', 'score': false},
      {'answerText': 'The Octopus', 'score': true},
    ],
  },
  {
    'question': 'Which European country eats the most chocolate per capita?',
    'answers': [
      {'answerText': 'Belgium', 'score': false},
      {'answerText': 'The Netherlands', 'score': false},
      {'answerText': 'Switzerland', 'score': true},
    ],
  },
];

