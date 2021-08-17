class VariantOptionValueRequest {
  int id;
  int idOrg;
  int idVariantOption;
  String optionValue;
  int idUserCreated;
  int idUserUpdated;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  VariantOptionValueRequest({
    required this.id,
    required this.idOrg,
    required this.idVariantOption,
    required this.optionValue,
    required this.idUserCreated,
    required this.idUserUpdated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory VariantOptionValueRequest.fromJson(Map<String, dynamic> json) {
    return VariantOptionValueRequest(
      id: json['id'],
      idOrg: json['idOrg'],
      idVariantOption: json['idVariantOption'],
      optionValue: json['optionValue'],
      idUserCreated: json['id_user_created'],
      idUserUpdated: json['id_user_updated'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
      deletedAt: (json['deleted_at'] != null) ? DateTime.parse(json['deleted_at'].toString()) : null,
    );
  }

  factory VariantOptionValueRequest.fromJsonData(Map<String, dynamic> json) {
    return VariantOptionValueRequest.fromJson(json['data']);
  }
}
