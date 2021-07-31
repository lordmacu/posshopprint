class CategoryRequest {
  int id;
  int idOrg;
  String name;
  String color;
  int idUserCreated;
  int idUserUpdated;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  int itemsCount;

  CategoryRequest({
    required this.id,
    required this.idOrg,
    required this.name,
    required this.color,
    required this.idUserCreated,
    required this.idUserUpdated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.itemsCount,
  });

  factory CategoryRequest.fromJson(Map<String, dynamic> json) {
    return CategoryRequest(
      id: json['id'],
      idOrg: json['idOrg'],
      name: json['name'],
      color: json['color'],
      idUserCreated: json['id_user_created'],
      idUserUpdated: json['id_user_updated'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
      deletedAt: (json['deleted_at'] != null) ? DateTime.parse(json['deleted_at'].toString()) : null,
      itemsCount: (json['items_count'] != null) ? json['items_count'] : 0,
    );
  }

  factory CategoryRequest.fromJsonData(Map<String, dynamic> json) {
    return CategoryRequest.fromJson(json['data']);
  }
}
