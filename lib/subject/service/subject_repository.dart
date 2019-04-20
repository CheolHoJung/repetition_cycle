import 'package:flutter/material.dart';
import 'package:repetition_cycle/subject/domain/subject.dart';
import 'package:repetition_cycle/subject/domain/subject_history.dart';

class SubjectRepository {
  static List<Subject> _subjects = [
    Subject.temp(1, '컴퓨터 구조', Colors.blue.value, [SubjectHistory(DateTime.parse('2019-03-10 12:10'))], 0),
    Subject.temp(2, '알고리즘', Colors.green.value, [SubjectHistory(DateTime.parse('2019-02-10 12:10'))], 1),
    Subject.temp(3, '자료구조', Colors.purple.value, [SubjectHistory(DateTime.parse('2019-01-10 12:10'))], 2),
    Subject.temp(4, 'subject', Colors.blue.value, [SubjectHistory(DateTime.parse('2018-12-10 12:10'))], 3),
    Subject.temp(5, 'subject2', Colors.blue.value, [SubjectHistory(DateTime.parse('2018-11-10 12:10'))], 4),
    Subject.temp(6, 'subject3', Colors.blue.value, [SubjectHistory(DateTime.parse('2018-10-10 12:10'))], 5),
    Subject.temp(7, 'subject4', Colors.blue.value, [SubjectHistory(DateTime.parse('2018-09-10 12:10'))], 6),
  ];
  static List<Subject> findAll() {
    List<Subject> result = List<Subject>.from(_subjects);
    result.sort((sub1, sub2) => sub1.pos - sub2.pos);
    return result;
  }

  static void save(Subject subject) {
    var index = _subjects.indexWhere((el) => el.key == subject.key);
    _subjects[index] = subject;
  }

  static void removeAt(int oldIndex) {
    _subjects.removeAt(oldIndex);
  }

  static void insert(int newIndex, Subject element) {
    _subjects.insert(newIndex, element);
  }
}