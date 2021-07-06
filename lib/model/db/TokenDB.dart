class TokenDB {
  int? id;
  String email;
  String password;

  TokenDB({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
      };

  factory TokenDB.fromMap(Map<String, dynamic> map) => TokenDB(
        email: map['email'],
        password: map['password'],
      );
}
