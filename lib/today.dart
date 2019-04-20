import 'package:flutter/material.dart';

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          'Wendsday ',
          style: Theme.of(context).textTheme.headline,
        ),
        Text('April 15')
      ],
    );
  }
}