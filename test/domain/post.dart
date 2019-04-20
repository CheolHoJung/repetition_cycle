import 'dart:async';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

class Post {
  Post();

  Post.make(this.id, this.msg, this.stars, this.read, this.at);

  @PrimaryKey()
  int id;

  @Column(isNullable: true)
  String msg;

  @Column(isNullable: true)
  bool read;

  @Column(isNullable: true)
  double stars;

  @Column(isNullable: true)
  DateTime at;

  String toString() =>
      'Post(id: $id, message: $msg, stars: $stars, read: $read, at: $at)';
}