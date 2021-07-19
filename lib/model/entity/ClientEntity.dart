import 'BaseEntity.dart';

class ClientEntity extends BaseEntity {
  String cutProvince;
  String name;
  String email;
  String address;
  String city;
  String freeNum;
  String customerCode;
  String postalCode;
  String comment;

  ClientEntity({
    int? id,
    required this.cutProvince,
    required this.name,
    required this.email,
    required this.address,
    required this.city,
    required this.freeNum,
    required this.customerCode,
    required this.postalCode,
    required this.comment,
  });

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'cutProvince': cutProvince,
        'name': name,
        'email': email,
        'address': address,
        'city': city,
        'freeNum': freeNum,
        'customerCode': customerCode,
        'postalCode': postalCode,
        'comment': comment,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return ClientEntity.fromMap(map);
  }

  factory ClientEntity.fromMap(Map<String, dynamic> map) => ClientEntity(
        id: map['id'],
        cutProvince: map['cutProvince'],
        name: map['name'],
        email: map['email'],
        address: map['address'],
        city: map['city'],
        freeNum: map['freeNum'],
        customerCode: map['customerCode'],
        postalCode: map['postalCode'],
        comment: map['comment'],
      );
}
