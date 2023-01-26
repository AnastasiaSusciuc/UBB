// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      id: json['_id'] as String?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      url: json['url'] as String?,
      yearsExperience: json['yearsExperience'] as int?,
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      '_id': instance.id,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'url': instance.url,
      'yearsExperience': instance.yearsExperience,
    };
