import 'package:posshop_app/model/dto/ItemRequest.dart';

import 'BaseEntity.dart';

class ItemEntity extends BaseEntity {
  int idCloud;
  String name;
  int? idCategory;
  int idDefaultSupplier;
  String type;
  int keepCount;
  bool divisible;
  bool freePrice;
  bool useProduction;
  bool allOutlets;
  int salePrice;
  int primeCost;
  int purchaseCost;
  String article;
  String color;
  String shape;
  String? wareImgName;
  String? barcode;
  List<dynamic>? taxIds;
  String? imageUrl;

  ItemEntity({
    int? id,
    required this.idCloud,
    required this.name,
    this.idCategory,
    required this.idDefaultSupplier,
    required this.type,
    required this.keepCount,
    required this.divisible,
    required this.freePrice,
    required this.useProduction,
    required this.allOutlets,
    required this.salePrice,
    required this.primeCost,
    required this.purchaseCost,
    required this.article,
    required this.color,
    required this.shape,
    this.wareImgName,
    this.barcode,
    this.taxIds,
    this.imageUrl,
  });

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'idCloud': idCloud,
        'name': name,
        'idCategory': idCategory,
        'idDefaultSupplier': idDefaultSupplier,
        'type': type,
        'keepCount': keepCount,
        'divisible': divisible,
        'freePrice': freePrice,
        'useProduction': useProduction,
        'allOutlets': allOutlets,
        'salePrice': salePrice,
        'primeCost': primeCost,
        'purchaseCost': purchaseCost,
        'article': article,
        'color': color,
        'shape': shape,
        'wareImgName': wareImgName,
        'barcode': barcode,
        'taxIds': taxIds,
        'imageUrl': imageUrl,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return ItemEntity.fromMap(map);
  }

  factory ItemEntity.fromMap(Map<String, dynamic> map) => ItemEntity(
        id: map['id'],
        idCloud: map['idCloud'],
        name: map['name'],
        idCategory: map['idCategory'],
        idDefaultSupplier: map['idDefaultSupplier'],
        type: map['type'],
        keepCount: map['keepCount'],
        divisible: map['divisible'],
        freePrice: map['freePrice'],
        useProduction: map['useProduction'],
        allOutlets: map['allOutlets'],
        salePrice: map['salePrice'],
        primeCost: map['primeCost'],
        purchaseCost: map['purchaseCost'],
        article: map['article'],
        color: map['color'],
        shape: map['shape'],
        wareImgName: map['wareImgName'],
        barcode: map['barcode'],
        taxIds: map['taxIds'],
        imageUrl: map['imageUrl'],
      );

  factory ItemEntity.fromRequest(ItemRequest request) => ItemEntity(
        idCloud: request.id,
        name: request.name,
        idCategory: request.idCategory,
        idDefaultSupplier: request.idDefaultSupplier,
        type: request.type,
        keepCount: request.keepCount,
        divisible: request.divisible,
        freePrice: request.freePrice,
        useProduction: request.useProduction,
        allOutlets: request.allOutlets,
        salePrice: request.salePrice,
        primeCost: request.primeCost,
        purchaseCost: request.purchaseCost,
        article: request.article,
        color: request.color,
        shape: request.shape,
        wareImgName: request.wareImgName,
        barcode: request.barcode,
        taxIds: request.taxIds,
        imageUrl: request.imageUrl,
      );

  @override
  String uniqueCloudKey() {
    return idCloud.toString();
  }
}
