import 'BaseEntity.dart';

class PosEntity extends BaseEntity {
  int storeId;
  String storeName;
  int posId;
  String posName;

  PosEntity({
    int? id,
    required this.storeId,
    required this.storeName,
    required this.posId,
    required this.posName,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() => {
        'storeId': storeId,
        'storeName': storeName,
        'posId': posId,
        'posName': posName,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return PosEntity.fromMap(map);
  }

  factory PosEntity.fromMap(Map<String, dynamic> map) => PosEntity(
        storeId: map['storeId'],
        storeName: map['storeName'],
        posId: map['posId'],
        posName: map['posName'],
      );

  @override
  String uniqueCloudKey() {
    throw UnimplementedError();
  }
}
