import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:repetition_cycle/subject/domain/subject.dart';
import 'package:repetition_cycle/subject/domain/subject_history.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/src/api/finder.dart';
import 'package:test_api/test_api.dart';

void main() {
  Database db;
  StoreRef store;

  setUp(() async {
    db = await databaseFactoryIo
        .openDatabase(join('.dart_tool', 'sembast', 'example', 'record_demo.db'));
    await db.clear();

    store = intMapStoreFactory.store('my_store');
    await store.drop(db);
  });

  test('create and find', () async {
    var key = await store.add(db, {'name': 'ugly'});
    var record = store.record(key);
    expect(record.key, 1);

    var value = await record.get(db);
    expect(value, {'name': 'ugly'});

    var records = await store.find(db, finder: Finder(filter: Filter.matches('name', '^ugl')));
    expect(records[0].value, value);
  });

  test('create and update', () async {
    // put
    var key = await store.add(db, {'name': 'ugly'});
    expect(key, 1);
    var record = store.record(key);


    // update
    expect(await record.update(db, {'new': 2}), {'name': 'ugly', 'new': 2});
    expect(await record.update(db, {'new': FieldValue.delete, 'a.b.c': 3}), {
      'name': 'ugly',
      'a': {
        'b': {'c': 3}
      }
    });
  });

  test('subjects', () async {
    var subject = Subject.fromJson({
      'key': 1,
      'name': '컴퓨터 구조',
      'color': Colors.blue.value,
      'history': [{
        'datetime': '2019-03-10 12:10'
      }],
      'pos': 0
    });

    print(subject.toJson());
    print(Subject.fromJson(subject.toJson()));

    // put
    var key = await store.add(db, subject.toJson());
    expect(key, 1);

    var record = store.record(key);
    print(await record.get(db));
    print(Subject.fromJson(await record.get(db)));
    print(await store.find(db));
  });

  test('subjects test', () async {
    List<Subject> _subjects = [
      Subject.temp2('컴퓨터 구조', Colors.blue.value, [SubjectHistory(DateTime.parse('2019-03-10 12:10'))], 0),
      Subject.temp2('알고리즘', Colors.green.value, [SubjectHistory(DateTime.parse('2019-02-10 12:10'))], 1),
      Subject.temp2('자료구조', Colors.purple.value, [SubjectHistory(DateTime.parse('2019-01-10 12:10'))], 2),
      Subject.temp2('subject', Colors.blue.value, [SubjectHistory(DateTime.parse('2018-12-10 12:10'))], 3),
      Subject.temp2('subject2', Colors.blue.value, [SubjectHistory(DateTime.parse('2018-11-10 12:10'))], 4),
      Subject.temp2('subject3', Colors.blue.value, [SubjectHistory(DateTime.parse('2018-10-10 12:10'))], 5),
      Subject.temp2('subject4', Colors.blue.value, [SubjectHistory(DateTime.parse('2018-09-10 12:10'))], 6),
    ];

    for (var json in _subjects.map((subject) => subject.toJson()).toList()) {
      await store.add(db, json);
    }
    var snapshots = await store.find(db);
    print(snapshots.map((snapshot) => Subject.fromRecord(snapshot.key, snapshot.value)).toList());
  });
}
