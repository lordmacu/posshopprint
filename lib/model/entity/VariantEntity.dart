import 'package:posshop_app/model/dto/VariantRequest.dart';

import 'BaseEntity.dart';

class VariantEntity extends BaseEntity {
  int idCloud;
  int idItem;
  bool allowedForAllOutlets;
  bool freePrice;
  String values;
  String article;
  String? barcode;
  int? oldePrice;
  int salePrice;
  int primeCost;

  VariantEntity({
    int? id,
    required this.idCloud,
    required this.idItem,
    required this.allowedForAllOutlets,
    required this.freePrice,
    required this.values,
    required this.article,
    required this.barcode,
    this.oldePrice,
    required this.salePrice,
    required this.primeCost,
  });

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'idCloud': idCloud,
        'idItem': idItem,
        'allowedForAllOutlets': allowedForAllOutlets,
        'freePrice': freePrice,
        'values': values,
        'article': article,
        'barcode': barcode,
        'oldePrice': oldePrice,
        'salePrice': salePrice,
        'primeCost': primeCost,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return VariantEntity.fromMap(map);
  }

  factory VariantEntity.fromMap(Map<String, dynamic> map) => VariantEntity(
        id: map['id'],
        idCloud: map['idCloud'],
        idItem: map['idItem'],
        allowedForAllOutlets: map['allowedForAllOutlets'],
        freePrice: map['freePrice'],
        values: map['values'],
        article: map['article'],
        barcode: map['barcode'],
        oldePrice: map['oldePrice'],
        salePrice: map['salePrice'],
        primeCost: map['primeCost'],
      );

  factory VariantEntity.fromRequest(VariantRequest request) => VariantEntity(
        idCloud: request.id,
        idItem: request.idItem,
        allowedForAllOutlets: request.allowedForAllOutlets,
        freePrice: request.freePrice,
        values: request.values,
        article: request.article,
        barcode: request.barcode,
        oldePrice: request.oldePrice,
        salePrice: request.salePrice,
        primeCost: request.primeCost,
      );

  @override
  String uniqueCloudKey() {
    return idCloud.toString();
  }
}
