import 'BaseEntity.dart';

class TokenEntity extends BaseEntity {
  String email;
  String password;
  String token;

  TokenEntity({
    int? id,
    required this.email,
    required this.password,
    required this.token,
  }) : super(id: id);

  @override
  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
        'token': token,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return TokenEntity.fromMap(map);
  }

  factory TokenEntity.fromMap(Map<String, dynamic> map) => TokenEntity(
        email: map['email'],
        password: map['password'],
        token: map['token'],
      );

  @override
  String uniqueCloudKey() {
    throw UnimplementedError();
  }
}
