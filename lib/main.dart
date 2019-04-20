import 'package:flutter/material.dart';
import 'package:repetition_cycle/Colors.dart';
import 'package:repetition_cycle/root_page.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  timeago.setLocaleMessages('ko', timeago.KoMessages());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'silgothic',
          primaryColor: kShrinePink50,
          backgroundColor: kShrinePink50,
          textTheme: TextTheme(
            headline: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
            title: TextStyle(fontSize: 15.0),
            body1: TextStyle(fontSize: 15.0),
          )),
      home: RootPage(),
    );
  }
}
