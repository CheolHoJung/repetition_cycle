import 'package:timeago/timeago.dart' as timeago;

class SubjectHistory {

  DateTime _datetime;

  SubjectHistory(this._datetime);

  String ago(DateTime clock) {

    return timeago.format(_datetime, locale: 'ko', clock: clock);
  }
}