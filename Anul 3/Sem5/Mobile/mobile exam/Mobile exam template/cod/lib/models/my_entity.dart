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
  String? description;
  String? ingredients;
  String? instructions;
  String? category;
  String? difficulty;

  MyEntity({
    this.id,
    required this.name,
    this.description,
    this.ingredients,
    this.instructions,
    this.category,
    this.difficulty,
  });

  factory MyEntity.fromJson(Map<String, dynamic> json) =>
      _$MyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MyEntityToJson(this);

}
