class TaxRequest {
  int id;
  int idOrg;
  String type;
  String name;
  double rate;
  bool allowedForAllOutlets;
  bool applyForAllNewWares;
  bool applyToAllWares;
  int idUserCreated;
  int idUserUpdated;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  TaxRequest({
    required this.id,
    required this.idOrg,
    required this.type,
    required this.name,
    required this.rate,
    required this.allowedForAllOutlets,
    required this.applyForAllNewWares,
    required this.applyToAllWares,
    required this.idUserCreated,
    required this.idUserUpdated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory TaxRequest.fromJson(Map<String, dynamic> json) {
    return TaxRequest(
      id: json['id'],
      idOrg: json['idOrg'],
      type: json['type'],
      name: json['name'],
      rate: json['rate'],
      allowedForAllOutlets: json['allowedForAllOutlets'],
      applyForAllNewWares: json['applyForAllNewWares'],
      applyToAllWares: json['applyToAllWares'],
      idUserCreated: json['id_user_created'],
      idUserUpdated: json['id_user_updated'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
      deletedAt: (json['deleted_at'] != null)
          ? DateTime.parse(json['deleted_at'].toString())
          : null,
    );
  }
}
