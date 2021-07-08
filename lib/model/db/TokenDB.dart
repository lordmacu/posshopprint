class TokenDB {
  int? id;
  String email;
  String password;
  String token;

  TokenDB({
    required this.email,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
        'token': token,
      };

  factory TokenDB.fromMap(Map<String, dynamic> map) => TokenDB(
        email: map['email'],
        password: map['password'],
        token: map['token'],
      );
}
