import 'ItemOutletRequest.dart';
import 'VariantOptionNameRequest.dart';
import 'VariantRequest.dart';

class ItemRequest {
  int id;
  int idOrg;
  int? idCategory;
  int idDefaultSupplier;
  String type;
  int keepCount;
  bool divisible;
  bool freePrice;
  bool useProduction;
  bool allOutlets;
  String name;
  int salePrice;
  int primeCost;
  int purchaseCost;
  String article;
  String color;
  String shape;
  String? wareImgName;
  String? barcode;
  int idUserCreated;
  int idUserUpdated;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  List<dynamic>? taxIds;
  String? imageUrl;
  List<VariantRequest>? variants;
  List<ItemOutletRequest>? itemsOutlet;
  List<VariantOptionNameRequest>? variantOptionsNameOutlet;

  ItemRequest({
    required this.id,
    required this.idOrg,
    this.idCategory,
    required this.idDefaultSupplier,
    required this.type,
    required this.keepCount,
    required this.divisible,
    required this.freePrice,
    required this.useProduction,
    required this.allOutlets,
    required this.name,
    required this.salePrice,
    required this.primeCost,
    required this.purchaseCost,
    required this.article,
    required this.color,
    required this.shape,
    this.wareImgName,
    this.barcode,
    required this.idUserCreated,
    required this.idUserUpdated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.taxIds,
    this.imageUrl,
    this.variants,
    this.itemsOutlet,
    this.variantOptionsNameOutlet,
  });

  factory ItemRequest.fromJson(Map<String, dynamic> json) {
    return ItemRequest(
      id: json['id'],
      idOrg: json['idOrg'],
      idCategory: json['idCategory'],
      idDefaultSupplier: json['idDefaultSupplier'],
      type: json['type'],
      keepCount: json['keepCount'],
      divisible: json['divisible'] != 0,
      freePrice: json['freePrice'] != 0,
      useProduction: json['useProduction'] != 0,
      allOutlets: json['allOutlets'] != 0,
      name: json['item_name'],
      salePrice: json['salePrice'],
      primeCost: json['primeCost'],
      purchaseCost: json['purchaseCost'],
      article: json['article'],
      color: json['color'],
      shape: json['shape'],
      wareImgName: json['wareImgName'],
      barcode: json['barcode'],
      idUserCreated: json['id_user_created'],
      idUserUpdated: json['id_user_updated'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
      deletedAt: (json['deleted_at'] != null) ? DateTime.parse(json['deleted_at'].toString()) : null,
      taxIds: json['taxIds'],
      imageUrl: json['imagen_url'],
      variants: (json['variants'] != null)
          ? List<VariantRequest>.from(json['variants'].map((model) => VariantRequest.fromJson(model)))
          : null,
      itemsOutlet: (json['items_outlets'] != null)
          ? List<ItemOutletRequest>.from(json['items_outlets'].map((model) => ItemOutletRequest.fromJson(model)))
          : null,
      variantOptionsNameOutlet: (json['variant_option_names'] != null)
          ? List<VariantOptionNameRequest>.from(json['variant_option_names'].map((model) => VariantOptionNameRequest.fromJsonWithIdItem(model, json['id'])))
          : null,
    );
  }

  factory ItemRequest.fromJsonData(Map<String, dynamic> json) {
    return ItemRequest.fromJson(json['data']);
  }
}
