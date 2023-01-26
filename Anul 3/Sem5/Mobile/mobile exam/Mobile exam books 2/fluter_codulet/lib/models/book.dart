import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@entity
@JsonSerializable()
class Book {
  @JsonKey(name: 'id')
  @PrimaryKey()
  String? id;
  String? title;
  String? status;
  String student;
  int? pages;
  int? usedCount;

  Book({
    this.id,
    required this.title,
    this.status,
    required this.student,
    this.pages,
    this.usedCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) =>
      _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

}
