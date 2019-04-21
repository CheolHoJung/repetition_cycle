import 'package:flutter/material.dart';
import 'package:repetition_cycle/subject/domain/subject.dart';

class SubjectSizedCard extends StatefulWidget {
  final Subject _subject;

  SubjectSizedCard(this._subject) : super(key : ValueKey(_subject.key));

  @override
  _SubjectSizedCardState createState() => _SubjectSizedCardState(_subject);
}

class _SubjectSizedCardState extends State<SubjectSizedCard> {
  final Subject _subject;

  _SubjectSizedCardState(this._subject);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widget.key,
      width: 180,
      child: Card(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('tab $_subject');
              },
              child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: _subject.color
                    ),
                    child: Row(
                      children: <Widget>[
//                        Icon(Icons.subject, size: 30.0, color: Colors.white,),
//                        Text(_subject.name,style: TextStyle(color: Colors.white),)
                        Icon(Icons.subject, size: 30.0, color: _subject.textColor),
                        Text(_subject.name,style: TextStyle(color: _subject.textColor),)
                      ],
                    ),
                  )
              ),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            Row(
              children: <Widget>[
                Text(_subject.days),
              ],
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            Row(children: <Widget>[
              Icon(Icons.access_time),
              Text(_subject.ago(DateTime.now()))
            ],)
          ],
        ),
      ),
    );
  }
}
