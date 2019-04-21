import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:reorderables/reorderables.dart';
import 'package:repetition_cycle/subject/domain/subject.dart';
import 'package:repetition_cycle/subject/service/subject_database.dart';
import 'package:repetition_cycle/subject_sized_card.dart';
import 'package:repetition_cycle/today.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Future<List<Subject>> _subjectsFuture;
  TextEditingController _nameForCreateController;
  FocusNode _focusNodeOfNameForCreate;
  Color _currentColor;

  _onClearName() {
    setState(() {
      _nameForCreateController.text = '';
    });
  }

  _pickColor() {
    Color pickerColor = _currentColor;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                pickerColor = color;
              },
              enableLabel: true,
              pickerAreaHeightPercent: 0.8,
              enableAlpha: false,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() {
                  _currentColor = pickerColor;
                });
                print(_currentColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    this._subjectsFuture = findAll();
    this._nameForCreateController = TextEditingController();
    this._focusNodeOfNameForCreate = FocusNode();
    this._currentColor = Colors.blue;
  }

  Future<List<Subject>> findAll() async {
    var db = await SubjectDatabase().get();
    return db.findAll();
  }

  updatePosition(int oldIndex, int newIndex) async {
    var db = await SubjectDatabase().get();
    await db.updatePosition(oldIndex, newIndex);
  }

  void updateAndRefresh(int oldIndex, int newIndex) async {
    await updatePosition(oldIndex, newIndex);
    // reload
    setState(() {
      _subjectsFuture = findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(_focusNodeOfNameForCreate);
          },
          backgroundColor: Theme.of(context).backgroundColor,
          shape: CircleBorder(side: BorderSide(color: Colors.black)),
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: Container(
          margin: MediaQuery.of(context).padding,
          child: Column(
            children: <Widget>[
              Today(),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              TextField(
                controller: _nameForCreateController,
                focusNode: _focusNodeOfNameForCreate,
                onEditingComplete: () async {
                  var text = _nameForCreateController.text;
                  if (text.isEmpty) {
                    _focusNodeOfNameForCreate.unfocus();
                    return;
                  }

                  var db = await SubjectDatabase().get();
                  await db.create(text, _currentColor);

                  setState(() {
                    this._subjectsFuture = findAll();
                  });

                  _onClearName();
                  _focusNodeOfNameForCreate.unfocus();
                },
                decoration: InputDecoration(
                    hintText: '+ add a new subject',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: IconButton(icon: Icon(Icons.color_lens), onPressed: _pickColor, color: _currentColor,),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: _onClearName)),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Expanded(
                child: FutureBuilder(
                  future: _subjectsFuture,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return new Text('loading...');
                      default:
                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        else {
                          List<Subject> data = snapshot.data;

                          return ReorderableWrap(
                            children: data
                                .map((subject) => SubjectSizedCard(subject))
                                .toList(),
                            onReorder: updateAndRefresh,
                            maxMainAxisCount: 2,
                          );
                        }
                    }
                },
              )),
            ],
          ),
        ));
  }
}
