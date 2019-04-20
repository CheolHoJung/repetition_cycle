//import 'package:flutter_test/flutter_test.dart';
//import 'package:repetition_cycle/domain/subject.dart';
//import 'package:repetition_cycle/domain/subjects.dart';
//
//
//void main() {
//  test('asdasd', () {
//    expect(() => Subjects(null), throwsAssertionError);
//  });
//
//  test('Duplicate', () {
//    expect(() => Subjects([Subject(0, '', 0), Subject(0, '', 0)]), throwsArgumentError);
//  });
//
//  test('Create new Subject from empty subjects', () {
//    var subjects = Subjects.empty();
//    var subject = subjects.createSubject('subject1');
//
//    expect(subject.pos, Subject.DEFAULT_POS);
//  });
//
//  test('Create new Subject from subjects have one element at 1', () {
//    var firstPos = 1;
//    var subjects = Subjects([Subject(0, 'subject1', firstPos)]);
//    var subject = subjects.createSubject('subject2');
//
//    expect(subject.pos, firstPos * 2);
//  });
//
//  test('Call move when is empty', () {
//    var subjects = Subjects.empty();
//
//    expect(() => subjects.move(0, 1), throwsAssertionError);
//  });
//
//  test('Pass not contains subject to move', () {
//    var subjects = createSubjects(3);
//
//    expect(() => subjects.findById(4), throwsStateError);
//  });
//
//  test('Pass larger than length toIndex move', () {
//    const lastIndex = 2;
//    var subjects = createSubjects(lastIndex + 1);
//
//    expect(() => subjects.move(0, lastIndex + 1), throwsAssertionError);
//  });
//
//  test('Move first subject to third in subjects has three elements', () {
//    var subjects = createSubjects(3);
//    const id = 0;
//    const to = 2;
//    var second = subjects.findById(id);
//
//    subjects.move(id, to);
//    expect(subjects.elementAt(to).id, second.id);
//  });
//}
//
//Subjects createSubjects(int count) {
//  var result = Subjects.empty();
//  addSubject(result, count);
//  return result;
//}
//
//void addSubject(Subjects subjects, int count) {
//  for (var i = 0; i < count; i++ ) {
//    subjects.createSubject('subject$i');
//  }
//}