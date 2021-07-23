class DiscountRequest {
  int id;
  int idOrg;
  String name;
  bool allowedForAllOutlets;
  bool limitedAccess;
  String calculationType;
  String type;
  double? value;
  int idUserCreated;
  int idUserUpdated;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  DiscountRequest({
    required this.id,
    required this.idOrg,
    required this.name,
    required this.allowedForAllOutlets,
    required this.limitedAccess,
    required this.calculationType,
    required this.type,
    this.value,
    required this.idUserCreated,
    required this.idUserUpdated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory DiscountRequest.fromJson(Map<String, dynamic> json) {
    return DiscountRequest(
      id: json['id'],
      idOrg: json['idOrg'],
      name: json['name'],
      allowedForAllOutlets: json['allowedForAllOutlets'] != 0,
      limitedAccess: json['limitedAccess'] != 0,
      calculationType: json['calculationType'],
      type: json['type'],
      value: (json['value'] != null)? double.parse(json['value']): null,
      idUserCreated: json['id_user_created'],
      idUserUpdated: json['id_user_updated'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
      deletedAt: (json['deleted_at'] != null)
          ? DateTime.parse(json['deleted_at'].toString())
          : null,
    );
  }

  factory DiscountRequest.fromJsonData(Map<String, dynamic> json) {
    return DiscountRequest.fromJson(json['data']);
  }
}
