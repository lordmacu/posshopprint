abstract class BaseEntity {
  int? id;

  BaseEntity({this.id});

  String uniqueCloudKey();

  Map<String, dynamic> toMap();

  BaseEntity fromMap(Map<String, dynamic> map);
}
