import 'package:posshop_app/model/dto/ItemRequest.dart';

import 'BaseEntity.dart';

class ItemEntity extends BaseEntity {
  int idCloud;
  String name;
  String color;
  int itemsCount;

  ItemEntity({
    int? id,
    required this.idCloud,
    required this.name,
    required this.color,
    required this.itemsCount,
  });

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'idCloud': idCloud,
        'name': name,
        'color': color,
        'itemsCount': itemsCount,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return ItemEntity.fromMap(map);
  }

  factory ItemEntity.fromMap(Map<String, dynamic> map) => ItemEntity(
        id: map['id'],
        idCloud: map['idCloud'],
        name: map['name'],
        color: map['color'],
        itemsCount: map['itemsCount'],
      );

  factory ItemEntity.fromRequest(ItemRequest request) => ItemEntity(
        idCloud: request.id,
        name: request.name,
        color: request.color,
        itemsCount: request.itemsCount,
      );

  @override
  String uniqueCloudKey() {
    return idCloud.toString();
  }
}
