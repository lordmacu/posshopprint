import 'package:posshop_app/model/dto/ItemOutletRequest.dart';

import 'BaseEntity.dart';

class ItemOutletEntity extends BaseEntity {
  int idCloud;
  int idItem;
  int idOutlet;
  String variantArticle;
  String variantValues;
  bool enable;
  int salePrice;
  int count;
  int criticalCount;
  int idealStock;

  ItemOutletEntity({
    int? id,
    required this.idCloud,
    required this.idItem,
    required this.idOutlet,
    required this.variantArticle,
    required this.variantValues,
    required this.enable,
    required this.salePrice,
    required this.count,
    required this.criticalCount,
    required this.idealStock,
  });

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'idCloud': idCloud,
        'idItem': idItem,
        'idOutlet': idOutlet,
        'variantArticle': variantArticle,
        'variantValues': variantValues,
        'enable': enable,
        'salePrice': salePrice,
        'count': count,
        'criticalCount': criticalCount,
        'idealStock': idealStock,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return ItemOutletEntity.fromMap(map);
  }

  factory ItemOutletEntity.fromMap(Map<String, dynamic> map) => ItemOutletEntity(
        id: map['id'],
        idCloud: map['idCloud'],
        idItem: map['idItem'],
        idOutlet: map['idOutlet'],
        variantArticle: map['variantArticle'],
        variantValues: map['variantValues'],
        enable: map['enable'],
        salePrice: map['salePrice'],
        count: map['count'],
        criticalCount: map['criticalCount'],
        idealStock: map['idealStock'],
      );

  factory ItemOutletEntity.fromRequest(ItemOutletRequest request) => ItemOutletEntity(
        idCloud: request.id,
        idItem: request.idItem,
        idOutlet: request.idOutlet,
        variantArticle: request.variantArticle,
        variantValues: request.variantValues,
        enable: request.enable,
        salePrice: request.salePrice,
        count: request.count,
        criticalCount: request.criticalCount,
        idealStock: request.idealStock,
      );

  @override
  String uniqueCloudKey() {
    return idCloud.toString();
  }
}
