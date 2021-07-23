import 'BaseEntity.dart';

class CategoryEntity extends BaseEntity {
  int idCloud;
  String name;
  String color;
  int itemsCount;

  CategoryEntity({
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
    return CategoryEntity.fromMap(map);
  }

  factory CategoryEntity.fromMap(Map<String, dynamic> map) => CategoryEntity(
        id: map['id'],
        idCloud: map['idCloud'],
        name: map['name'],
        color: map['color'],
        itemsCount: map['itemsCount'],
      );

  @override
  String uniqueCloudKey() {
    return idCloud.toString();
  }
}
