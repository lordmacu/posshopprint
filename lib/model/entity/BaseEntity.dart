abstract class BaseEntity {
  int? id;

  BaseEntity({this.id});

  Map<String, dynamic> toMap();

  BaseEntity fromMap(Map<String, dynamic> map);
}
