class User {
  int id;
  int idOrg;
  String name;
  String email;
  String? phone;
  String pin;
  String type;
  int status;

  User({
    required this.id,
    required this.idOrg,
    required this.name,
    required this.email,
    this.phone,
    required this.pin,
    required this.type,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      idOrg: json['idOrg'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      pin: json['pin'],
      type: json['type'],
      status: json['status'],
    );
  }
}
