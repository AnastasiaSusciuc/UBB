// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyEntity _$MyEntityFromJson(Map<String, dynamic> json) => MyEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      level: json['level'] as int?,
      status: json['status'] as String?,
      from: json['from'] as int?,
      to: json['to'] as int?,
    );

Map<String, dynamic> _$MyEntityToJson(MyEntity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'level': instance.level,
      'status': instance.status,
      'from': instance.from,
      'to': instance.to,
    };
