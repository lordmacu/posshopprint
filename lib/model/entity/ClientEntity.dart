import 'BaseEntity.dart';

class ClientEntity extends BaseEntity {
  int idOrg;
  int? idCountry;
  String cutProvince;
  String name;
  String email;
  String address;
  String city;
  String freeNum;
  String customerId;
  String customerCode;
  String postalCode;
  int points;
  int visits;
  int spentMoney;
  String comment;
  int idUserCreated;
  int idUserUpdated;
  DateTime? firstVisitDate;
  DateTime? lastVisitDate;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  ClientEntity({
    int? id,
    required this.idOrg,
    this.idCountry,
    required this.cutProvince,
    required this.name,
    required this.email,
    required this.address,
    required this.city,
    required this.freeNum,
    required this.customerId,
    required this.customerCode,
    required this.postalCode,
    required this.points,
    required this.visits,
    required this.spentMoney,
    required this.comment,
    required this.idUserCreated,
    required this.idUserUpdated,
    this.firstVisitDate,
    this.lastVisitDate,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'idOrg': idOrg,
    'idCountry': idCountry,
    'cutProvince': cutProvince,
    'name': name,
    'email': email,
    'address': address,
    'city': city,
    'freeNum': freeNum,
    'customerId': customerId,
    'customerCode': customerCode,
    'postalCode': postalCode,
    'points': points,
    'visits': visits,
    'spentMoney': spentMoney,
    'comment': comment,
    'idUserCreated': idUserCreated,
    'idUserUpdated': idUserUpdated,
    'firstVisitDate': firstVisitDate,
    'lastVisitDate': lastVisitDate,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'deletedAt': deletedAt,
  };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return ClientEntity.fromMap(map);
  }

  factory ClientEntity.fromMap(Map<String, dynamic> map) => ClientEntity(
      id: map['id'],
      idOrg: map['idOrg'],
      idCountry: map['idCountry'],
      cutProvince: map['cutProvince'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
      city: map['city'],
      freeNum: map['freeNum'],
      customerId: map['customerId'],
      customerCode: map['customerCode'],
      postalCode: map['postalCode'],
      points: map['points'],
      visits: map['visits'],
      spentMoney: map['spentMoney'],
      comment: map['comment'],
      idUserCreated: map['idUserCreated'],
      idUserUpdated: map['idUserUpdated'],
      firstVisitDate: map['firstVisitDate'],
      lastVisitDate: map['lastVisitDate'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
    );
}
