import 'package:repetition_cycle/subject/domain/subject_history.dart';

class Subject {

  int _key;

  String _name;

  int _color;

  List<SubjectHistory> _history;

  int pos;

  Subject(this._key, this._name, this.pos);

  Subject.temp(this._key, this._name, this._color, this._history, this.pos);

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