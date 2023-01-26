import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

@entity
@JsonSerializable()
class Teacher {
  @primaryKey
  @JsonKey(name: '_id')
  String? id;
  String? lastName;
  String? firstName;
  String? url;
  int? yearsExperience;

  Teacher({
    this.id,
    required this.lastName,
    this.firstName,
    required this.url,
    this.yearsExperience,
  }) {
    // dateTaken = DateTime.now().millisecondsSinceEpoch;
  }

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherToJson(this);

}
