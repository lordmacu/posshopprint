import 'UserRequest.dart';

class LoginRequest {
  String token;
  UserRequest user;

  LoginRequest({
    required this.token,
    required this.user,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      token: json['data']['token'],
      user: UserRequest.fromJson(json['data']['user']),
    );
  }
}
