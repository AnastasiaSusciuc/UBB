import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_entity.g.dart';

@entity
@JsonSerializable()
class MyEntity {
  @JsonKey(name: 'id')
  @PrimaryKey()
  int? id;
  String? name;
  int? level;
  String? status;
  int? from;
  int? to;

  MyEntity({
    this.id,
    required this.name,
    this.level,
    required this.status,
    this.from,
    this.to,
  });

  factory MyEntity.fromJson(Map<String, dynamic> json) =>
      _$MyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MyEntityToJson(this);

}
