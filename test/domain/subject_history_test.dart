import 'package:flutter_test/flutter_test.dart';
import 'package:repetition_cycle/subject/domain/subject_history.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  timeago.setLocaleMessages('ko', timeago.KoMessages());

  test('15 min ago (lirary use to parse string)', () {
    var now = DateTime.parse('2019-12-10 12:25');
    var ago = DateTime.parse('2019-12-10 12:10');

    expect(timeago.format(ago, locale: 'ko', clock: now), '15 분 전');
  });

  test('15 min ago (lirary)', () {
    var now = DateTime(2019, 12, 10, 12, 10 + 15);
    var ago = DateTime(2019, 12, 10, 12, 10);

    expect(timeago.format(ago, locale: 'ko', clock: now), '15 분 전');
  });

  test('15 min ago (history)', () {
    var now = DateTime(2019, 12, 10, 12, 25);
    var subjectHistory = SubjectHistory(now.subtract(Duration(minutes: 15)));

    expect(subjectHistory.ago(now), '15 분 전');
  });

  test('15 min ago (history from DateTime.now())', () {
    var now = DateTime.now();
    var subjectHistory = SubjectHistory(now.subtract(Duration(minutes: 15)));

    expect(subjectHistory.ago(now), '15 분 전');
  });
}