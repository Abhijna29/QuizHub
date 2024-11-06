import "package:flutter/material.dart";
import "package:quizhub/home.dart";

class ResultPage extends StatefulWidget {
  final int marks;
  const ResultPage({super.key, required this.marks});
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<String> images = [
    "images/success.jpg",
    "images/good.jpg",
    "images/bad.jpg"
  ];
  late String message;
  late String image;

  @override
  void initState() {
    super.initState();
    int marks = widget.marks;
    if (marks <= 10) {
      image = images[2];
      message = "You must work hard!!\n Your score: ${widget.marks}";
    } else if (marks <= 30) {
      image = images[1];
      message = "You can do better :)\n Your score: ${widget.marks}";
    } else {
      image = images[0];
      message = "Excellent! You did very well..\n Your Score:${widget.marks}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(204, 244, 244, 4),
        title: const Text("Result",
            style: TextStyle(
              fontFamily: 'Ubuntu',
            )),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Material(
                elevation: 10.0,
                child: Column(children: <Widget>[
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
                  Material(
                    child: SizedBox(
                      width: 200.0,
                      height: 200.0,
                      child: ClipRect(
                        child: Image(
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 15.0,
                      ),
                      child: Center(
                          child: Text(message,
                              style: const TextStyle(
                                  fontSize: 18.0, fontFamily: 'Ubuntu'))))
                ])),
          ),
          Expanded(
            flex: 4,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      },
                      style: OutlinedButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor:
                              const Color.fromARGB(204, 244, 244, 4),
                          side: BorderSide.none,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 45)),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Ubuntu',
                          color: Color.fromARGB(255, 60, 54, 2),
                        ),
                      ))
                ]),
          ),
        ],
      ),
    );
  }
}
