import 'package:posshop_app/model/dto/ProvinceRequest.dart';

class ClientRequest {
  int id;
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
  ProvinceRequest province;

  ClientRequest({
    required this.id,
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
    required this.province,
  });

  factory ClientRequest.fromJson(Map<String, dynamic> json) {
    return ClientRequest(
      id: json['id'],
      idOrg: json['idOrg'],
      idCountry: json['idCountry'],
      cutProvince: json['cut_comuna'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      city: json['city'],
      freeNum: json['freeNum'],
      customerId: json['customerId'],
      customerCode: json['customerCode'],
      postalCode: json['postalCode'],
      points: json['points'],
      visits: json['visits'],
      spentMoney: json['spentMoney'],
      comment: json['comment'],
      idUserCreated: json['id_user_created'],
      idUserUpdated: json['id_user_updated'],
      firstVisitDate: (json['firstVisitDate'] != null)
          ? DateTime.parse(json['firstVisitDate'].toString())
          : null,
      lastVisitDate: (json['lastVisitDate'] != null)
          ? DateTime.parse(json['lastVisitDate'].toString())
          : null,
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
      deletedAt: (json['deleted_at'] != null)
          ? DateTime.parse(json['deleted_at'].toString())
          : null,
      province: ProvinceRequest.fromJson(json['province']),
    );
  }

  factory ClientRequest.fromJsonData(Map<String, dynamic> json) {
    return ClientRequest.fromJson(json['data']);
  }
}
