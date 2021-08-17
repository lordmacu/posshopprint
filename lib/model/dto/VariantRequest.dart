class VariantRequest {
  int id;
  int idOrg;
  int idItem;
  bool allowedForAllOutlets;
  bool freePrice;
  String values;
  String article;
  String? barcode;
  int? oldePrice;
  int salePrice;
  int primeCost;
  int idUserCreated;
  int idUserUpdated;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  VariantRequest({
    required this.id,
    required this.idOrg,
    required this.idItem,
    required this.allowedForAllOutlets,
    required this.freePrice,
    required this.values,
    required this.article,
    this.barcode,
    this.oldePrice,
    required this.salePrice,
    required this.primeCost,
    required this.idUserCreated,
    required this.idUserUpdated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory VariantRequest.fromJson(Map<String, dynamic> json) {
    return VariantRequest(
      id: json['id'],
      idOrg: json['idOrg'],
      idItem: json['idItem'],
      allowedForAllOutlets: json['allowedForAllOutlets'] != 0,
      freePrice: json['freePrice'] != 0,
      values: json['values'],
      article: json['article'],
      barcode: json['barcode'],
      oldePrice: json['oldePrice'],
      salePrice: json['salePrice'],
      primeCost: json['primeCost'],
      idUserCreated: json['id_user_created'],
      idUserUpdated: json['id_user_updated'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
      deletedAt: (json['deleted_at'] != null) ? DateTime.parse(json['deleted_at'].toString()) : null,
    );
  }

  factory VariantRequest.fromJsonData(Map<String, dynamic> json) {
    return VariantRequest.fromJson(json['data']);
  }
}
