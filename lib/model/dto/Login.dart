import 'User.dart';

class Login {
  String token;
  User user;

  Login({
    required this.token,
    required this.user,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      token: json['data']['token'],
      user: User.fromJson(json['data']['user']),
    );
  }
}
