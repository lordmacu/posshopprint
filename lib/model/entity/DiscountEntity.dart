import 'package:posshop_app/model/dto/DiscountRequest.dart';

import 'BaseEntity.dart';

class DiscountEntity extends BaseEntity {
  String name;
  String calculationType;
  double value;

  DiscountEntity({
    int? id,
    required this.name,
    required this.calculationType,
    required this.value,
  }) : super (id: id);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'calculationType': calculationType,
        'value': value,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return DiscountEntity.fromMap(map);
  }

  factory DiscountEntity.fromMap(Map<String, dynamic> map) => DiscountEntity(
        id: map['id'],
        name: map['name'],
        calculationType: map['calculationType'],
        value: map['value'],
      );

  factory DiscountEntity.fromRequest(DiscountRequest request) => DiscountEntity(
        id: request.id,
        name: request.name,
        calculationType: request.calculationType,
        value: request.value,
      );
}
