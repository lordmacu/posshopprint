class ItemOutletRequest {
  int id;
  int idOrg;
  int idItem;
  int idOutlet;
  String variantArticle;
  String variantValues;
  bool enable;
  int salePrice;
  int count;
  int criticalCount;
  int idealStock;
  int idUserCreated;
  int idUserUpdated;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  ItemOutletRequest({
    required this.id,
    required this.idOrg,
    required this.idItem,
    required this.idOutlet,
    required this.variantArticle,
    required this.variantValues,
    required this.enable,
    required this.salePrice,
    required this.count,
    required this.criticalCount,
    required this.idealStock,
    required this.idUserCreated,
    required this.idUserUpdated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ItemOutletRequest.fromJson(Map<String, dynamic> json) {
    return ItemOutletRequest(
      id: json['id'],
      idOrg: json['idOrg'],
      idItem: json['idItem'],
      idOutlet: json['idOutlet'],
      variantArticle: json['variantArticle'],
      variantValues: json['variantValues'],
      enable: json['enable'] != 0,
      salePrice: json['salePrice'],
      count: json['count'],
      criticalCount: json['criticalCount'],
      idealStock: json['idealStock'],
      idUserCreated: json['id_user_created'],
      idUserUpdated: json['id_user_updated'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
      deletedAt: (json['deleted_at'] != null) ? DateTime.parse(json['deleted_at'].toString()) : null,
    );
  }

  factory ItemOutletRequest.fromJsonData(Map<String, dynamic> json) {
    return ItemOutletRequest.fromJson(json['data']);
  }
}
