import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:test_api/test_api.dart';
import 'package:flutter/widgets.dart';

void main() async {
  run();
}

void run() async {
  SqfliteAdapter _adapter;

  setUp(() async {
    var dbPath = await getDatabasesPath();
    _adapter = new SqfliteAdapter(path.join(dbPath, 'test.db'));

    await _adapter.connect();
  });

  test('test', () async {
//    final bean = PostBean(_adapter);
//    bean.drop();
//    await bean.drop();
//    print('create table..');
//    await bean.createTable();
//    print('successful');
  });
}