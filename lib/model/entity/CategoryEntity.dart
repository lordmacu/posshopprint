import 'BaseEntity.dart';

class CategoryEntity extends BaseEntity {
  int idOrg;
  String name;
  String color;
  int idUserCreated;
  int idUserUpdated;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  int itemsCount;

  CategoryEntity({
    int? id,
    required this.idOrg,
    required this.name,
    required this.color,
    required this.idUserCreated,
    required this.idUserUpdated,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.itemsCount,
  });

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'idOrg': idOrg,
        'name': name,
        'color': color,
        'idUserCreated': idUserCreated,
        'idUserUpdated': idUserUpdated,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'itemsCount': itemsCount,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return CategoryEntity.fromMap(map);
  }

  factory CategoryEntity.fromMap(Map<String, dynamic> map) => CategoryEntity(
        id: map['id'],
        idOrg: map['idOrg'],
        name: map['name'],
        color: map['color'],
        idUserCreated: map['idUserCreated'],
        idUserUpdated: map['idUserUpdated'],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt'],
        deletedAt: map['deletedAt'],
        itemsCount: map['itemsCount'],
      );
}
