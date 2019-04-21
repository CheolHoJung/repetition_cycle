import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:repetition_cycle/subject/domain/subject_history.dart';

class Subject {

  int _key;

  String _name;

  int _color;

  List<SubjectHistory> _history;

  int pos;

  Subject(this._key, this._name, this.pos);

  Subject.temp(this._key, this._name, this._color, this._history, this.pos);
  Subject.temp2(this._name, this._color, this._history, this.pos);
  Subject.fromJson(Map json) {
    this._key = json['key'];
    this._name = json['name'];
    this._color = json['color'];
    this.pos = json['pos'];

    final List<SubjectHistory> history = [];
    for (var a in json['history']) {
      history.add(SubjectHistory.fromJson(a));
    }

    this._history = history;
  }

  Subject.fromRecord(int key, Map json) {
    this._key = key;
    this._name = json['name'];
    this._color = json['color'];
    this.pos = json['pos'];

    final List<SubjectHistory> history = [];
    for (var a in json['history']) {
      history.add(SubjectHistory.fromJson(a));
    }

    this._history = history;
  }

  Map toJson() {
    var map = {
      'key': this._key,
      'name': this._name,
      'color': this._color,
      'history': this._history.map((history) => history.toJson()).toList(),
      'pos': this.pos
    };

    return map;
  }

  String get days {
    if (_history.isEmpty) {
      return '학습기록 없음';
    }
    var days = _history.length;
    return '$days 일차';
  }

  String ago(DateTime clock) {
    if (_history.isEmpty) {
      return '학습기록 없음';
    }
    return _history.last.ago(clock);
  }

  int get color => _color;

  String get name => _name;

  int get key => _key;
}