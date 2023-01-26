// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyEntity _$MyEntityFromJson(Map<String, dynamic> json) => MyEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      ingredients: json['ingredients'] as String?,
      instructions: json['instructions'] as String?,
      category: json['category'] as String?,
      difficulty: json['difficulty'] as String?,
    );

Map<String, dynamic> _$MyEntityToJson(MyEntity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'category': instance.category,
      'difficulty': instance.difficulty,
    };
