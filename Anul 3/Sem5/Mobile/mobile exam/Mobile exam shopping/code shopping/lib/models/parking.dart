import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking.g.dart';

@entity
@JsonSerializable()
class Parking {
  @JsonKey(name: 'id')
  @PrimaryKey()
  int? id;
  String? number;
  String? address;
  String? status;
  int? count;

  Parking({
    this.id,
    required this.number,
    required this.status,
    required this.address,
    required this.count,
  });

  factory Parking.fromJson(Map<String, dynamic> json) =>
      _$ParkingFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingToJson(this);

}
