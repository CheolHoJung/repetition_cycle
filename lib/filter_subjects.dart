import 'package:flutter/material.dart';

class FilterSubjects extends StatefulWidget {
  @override
  _FilterSubjectsState createState() => _FilterSubjectsState();
}

class _FilterSubjectsState extends State<FilterSubjects> {
  TextEditingController _searchSubjectController = TextEditingController();

  _onClear() {
    setState(() {
      _searchSubjectController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _searchSubjectController,
                decoration: InputDecoration(
                    hintText: 'Search a subject',
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                        icon: Icon(Icons.cancel), onPressed: _onClear)),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      var text = _searchSubjectController.text;
                      return AlertDialog(content: Text('search : $text'));
                    });
              },
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
        ),
      ],
    );
  }
}