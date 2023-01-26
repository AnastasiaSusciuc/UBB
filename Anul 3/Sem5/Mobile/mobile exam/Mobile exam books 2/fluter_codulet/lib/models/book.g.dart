// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as String?,
      title: json['title'] as String?,
      status: json['status'] as String?,
      student: json['student'] as String,
      pages: json['pages'] as int?,
      usedCount: json['usedCount'] as int?,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'student': instance.student,
      'pages': instance.pages,
      'usedCount': instance.usedCount,
    };
