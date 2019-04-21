import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:repetition_cycle/subject/domain/subject.dart';
import 'package:repetition_cycle/subject/domain/subject_history.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

class SubjectDatabase {
  static final SubjectDatabase _instance = new SubjectDatabase.internal();
  factory SubjectDatabase() => _instance;

  static Database _db;
  static StoreRef _store;

  Future<SubjectDatabase> get() async {
    if (_db != null) return _instance;

    await initDb();
    return _instance;
  }

  SubjectDatabase.internal();

  initDb() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    _db = await databaseFactoryIo
        .openDatabase(join(appDocDirectory.path, '.dart_tool', 'sembast', 'example', 'record_demo.db'));

    await _db.clear();

    _store = intMapStoreFactory.store('my_store');
    await _store.drop(_db);

    List<Subject> _subjects = [
      Subject.temp2('컴퓨터 구조', Colors.blue.value, [SubjectHistory(DateTime.parse('2019-03-10 12:10'))], 0),
      Subject.temp2('알고리즘', Colors.grey.value, [SubjectHistory(DateTime.parse('2019-02-10 12:10'))], 1),
      Subject.temp2('자료구조', Colors.purple.value, [SubjectHistory(DateTime.parse('2019-01-10 12:10'))], 2),
      Subject.temp2('운영체제', Colors.purple.value, [SubjectHistory(DateTime.parse('2018-12-10 12:10'))], 3),
      Subject.temp2('데이터베이스', Colors.blueGrey.value, [SubjectHistory(DateTime.parse('2018-11-10 12:10'))], 4),
      Subject.temp2('시스템프로그래밍', Colors.deepOrange.value, [SubjectHistory(DateTime.parse('2018-10-10 12:10'))], 5),
      Subject.temp2('네트워크', Colors.black.value, [SubjectHistory(DateTime.parse('2018-09-10 12:10'))], 6),
    ];

    for (var json in _subjects.map((subject) => subject.toJson()).toList()) {
      await _store.add(_db, json);
    }
  }

  Future<List<Subject>> findAll() async {
    var snapshots = await _store.find(_db, finder: Finder(
      sortOrders: [SortOrder('pos')]
    ));

    return snapshots.map((snapshot) {
      return Subject.fromRecord(snapshot.key, snapshot.value);
    }).toList();
  }

  updatePosition(int oldIndex, int newIndex) async {
    List<Subject> subjects = await findAll();
    Subject row = subjects.removeAt(oldIndex);
    subjects.insert(newIndex, row);

    for (var i = 0; i < subjects.length; i++) {
      var record = _store.record(subjects[i].key);
      await record.update(_db, {
        'pos': i
      });
    }
  }

  create(String text, Color color) async {
    List<Subject> subjects = await findAll();
    var subject = Subject.temp2(text, color.value, [], subjects.length);
    await _store.add(_db, subject.toJson());
  }
}