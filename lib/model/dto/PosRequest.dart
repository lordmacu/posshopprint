class PosRequest {
  int id;
  String name;

  PosRequest({
    required this.id,
    required this.name,
  });

  factory PosRequest.fromJson(Map<String, dynamic> json) => PosRequest(
        id: json['id'],
        name: json['name'],
      );
}
