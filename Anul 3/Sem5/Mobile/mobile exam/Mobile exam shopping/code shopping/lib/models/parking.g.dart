// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parking _$ParkingFromJson(Map<String, dynamic> json) => Parking(
      id: json['id'] as int?,
      number: json['number'] as String?,
      status: json['status'] as String?,
      address: json['address'] as String?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$ParkingToJson(Parking instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'address': instance.address,
      'status': instance.status,
      'count': instance.count,
    };
