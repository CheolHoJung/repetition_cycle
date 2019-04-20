import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:repetition_cycle/subject/domain/subject.dart';
import 'package:repetition_cycle/subject/service/subject_service.dart';
import 'package:repetition_cycle/subject/widget/subject_sized_card.dart';

class SubjectSizedCards extends StatefulWidget {

  final List<SubjectSizedCard> _cards;

  SubjectSizedCards(List<Subject> subjects) : _cards = subjects.map((subject) => SubjectSizedCard(subject)).toList();

  @override
  _SubjectSizedCardsState createState() => _SubjectSizedCardsState(_cards);
}

class _SubjectSizedCardsState extends State<SubjectSizedCards> {

  final List<SubjectSizedCard> _cards;

  _SubjectSizedCardsState(this._cards);

  void _updatePositions() {
    setState(() {
      for (var i = 0; i < _cards.length; i++) {
        _cards[i].subject.pos = i;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        SubjectSizedCard row = _cards.removeAt(oldIndex);
        _cards.insert(newIndex, row);

        _updatePositions();
        SubjectService.saveAll(_cards.map((card) => card.subject).toList());
      });
    }

    return Expanded(
      child: ReorderableWrap(
        children: _cards,
        onReorder: _onReorder,
        maxMainAxisCount: 2,
      ),
    );
  }
}
