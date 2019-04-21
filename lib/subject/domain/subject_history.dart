import 'package:timeago/timeago.dart' as timeago;

class SubjectHistory {

  DateTime _datetime;

  SubjectHistory(this._datetime);
  SubjectHistory.fromJson(Map json) {
    this._datetime = DateTime.parse(json['datetime']);
  }

  String ago(DateTime clock) {
    return timeago.format(_datetime, locale: 'ko', clock: clock);
  }

  Map toJson() {
    return {
      'datetime': _datetime.toString()
    };
  }

  @override
  String toString() {
    return 'SubjectHistory{_datetime: $_datetime}';
  }
}