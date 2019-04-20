import 'package:flutter/material.dart';
import 'package:repetition_cycle/filter_subjects.dart';
import 'package:repetition_cycle/subject/service/subject_service.dart';
import 'package:repetition_cycle/subject/widget/subject_sized_cards.dart';
import 'package:repetition_cycle/today.dart';

class RootPage extends StatefulWidget {

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          margin: MediaQuery.of(context).padding,
          child: Column(
            children: <Widget>[
              Today(),
              Padding(padding: EdgeInsets.all(10.0),),
              FilterSubjects(),
              SubjectSizedCards(SubjectService.findAll()),
            ],
          ),
        ));
  }
}