//import 'package:path/path.dart';
//import 'package:sembast/sembast.dart';
//import 'package:sembast/sembast_io.dart';
//import 'package:sembast/src/api/finder.dart';
//import 'package:test_api/test_api.dart';
//
//void main() {
//  Database db;
//  StoreRef store;
//
//  setUp(() async {
//    db = await databaseFactoryIo
//        .openDatabase(join('.dart_tool', 'sembast', 'example', 'record_demo.db'));
//    await db.clear();
//
//    store = intMapStoreFactory.store('my_store');
//    await store.drop(db);
//  });
//
//  test('create and find', () async {
//    var key = await store.add(db, {'name': 'ugly'});
//    var record = store.record(key);
//    expect(record.key, 1);
//
//    var value = await record.get(db);
//    expect(value, {'name': 'ugly'});
//
//    var records = await store.find(db, finder: Finder(filter: Filter.matches('name', '^ugl')));
//    expect(records[0].value, value);
//  });
//
//  test('create and update', () async {
//    // put
//    var key = await store.add(db, {'name': 'ugly'});
//    expect(key, 1);
//    var record = store.record(key);
//
//    // update
//    expect(await record.update(db, {'new': 2}), {'name': 'ugly', 'new': 2});
//    expect(await record.update(db, {'new': FieldValue.delete, 'a.b.c': 3}), {
//      'name': 'ugly',
//      'a': {
//        'b': {'c': 3}
//      }
//    });
//  });
//}
