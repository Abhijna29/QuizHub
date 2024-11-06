// ignore_for_file: prefer_const_constructors

import "dart:async";
import "dart:convert";

import "package:flutter/material.dart";
import "package:quizhub/result.dart";

class GetJson extends StatelessWidget {
  final String langName;

  const GetJson(this.langName, {super.key});

  String get assetToLoad {
    switch (langName) {
      case "Technology":
        return "assets/tech.json";
      case "Sports":
        return "assets/sports.json";
      case "Geography":
        return "assets/geography.json";
      case "Health and nutrition":
        return "assets/health.json";
      case "Current affairs":
        return "assets/current_affairs.json";
      default:
        throw Exception("Unknown Language:$langName");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(assetToLoad),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: Text("Loading")),
          );
        } else {
          List mydata = json.decode(snapshot.data.toString());
          return QuizPage(myData: mydata);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  final List myData;
  const QuizPage({super.key, required this.myData});
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Color colorToShow;
  final Color rightColor = Colors.green;
  final Color wrongColor = Colors.red;

  int questionIndex = 1;
  int marks = 0;
  bool disableAnswer = false;

  int timer = 30;
  late String showTimer;
  bool cancelTimer = false;
  late Map<String, Color> btnClr;

  @override
  void initState() {
    super.initState();
    showTimer = '30';
    btnClr = {
      "a": Colors.yellow,
      "b": Colors.yellow,
      "c": Colors.yellow,
      "d": Colors.yellow,
    };
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      if (mounted) {
        setState(() {
          if (timer < 1) {
            t.cancel();
            nextQuestion();
          } else if (cancelTimer) {
            t.cancel();
          } else {
            timer--;
          }
          showTimer = timer.toString();
        });
      }
    });
  }

  void nextQuestion() {
    cancelTimer = false;
    timer = 30;
    showTimer = timer.toString();
    startTimer();

    setState(() {
      if (questionIndex < widget.myData[0].length) {
        questionIndex++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(marks: marks),
        ));
      }
      btnClr.updateAll((key, value) => Colors.yellow);
      disableAnswer = false;
    });
  }

  void checkAnswer(String k) {
    if (widget.myData[2][questionIndex.toString()] ==
        widget.myData[1][questionIndex.toString()][k]) {
      marks = marks + 10;
      colorToShow = rightColor;
    } else {
      colorToShow = wrongColor;
    }
    setState(() {
      btnClr[k] = colorToShow;
      cancelTimer = true;
      disableAnswer = true;
    });
    Timer(Duration(seconds: 2), nextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: MaterialButton(
        onPressed: () => checkAnswer(k),
        color: btnClr[k],
        splashColor: Colors.yellow[400],
        minWidth: 300.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text(
          widget.myData[1][questionIndex.toString()][k],
          style: TextStyle(
            color: Color.fromARGB(255, 60, 54, 2),
            fontFamily: 'Ubuntu',
            fontSize: 16,
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You cannot exit at this stage",
            style: TextStyle(fontFamily: 'Ubuntu')),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.yellow,
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                widget.myData[0][questionIndex.toString()],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.0,
                  color: Color.fromARGB(255, 60, 54, 2),
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: AbsorbPointer(
              absorbing: disableAnswer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  choiceButton('a'),
                  choiceButton('b'),
                  choiceButton('c'),
                  choiceButton('d'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(showTimer,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Ubuntu',
                      )),
                )),
          )
        ],
      ),
    );
  }
}
