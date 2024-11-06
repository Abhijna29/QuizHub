import "package:flutter/material.dart";
import "package:quizhub/quizpage.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    "images/tech.jpg",
    "images/sports.jpg",
    "images/geography.jpg",
    "images/health.jpg",
    "images/current-affairs.jpg"
  ];
  Widget customCard(String lang, String img) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 20,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => GetJson(lang),
          ));
        },
        child: Material(
          color: const Color.fromARGB(204, 244, 244, 4),
          elevation: 3.0,
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    height: 150.0,
                    width: 250.0,
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        img,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                  child: Text(
                lang,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(204, 244, 244, 4),
        title: const Center(
          child: Text(
            "QuizHub",
            style: TextStyle(
              fontSize: 35,
              fontFamily: "DancingScript",
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          customCard("Technology", images[0]),
          customCard("Sports", images[1]),
          customCard("Geography", images[2]),
          customCard("Health and nutrition", images[3]),
          customCard("Current affairs", images[4])
        ],
      ),
    );
  }
}
