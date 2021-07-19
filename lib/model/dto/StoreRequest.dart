import 'PosRequest.dart';

class StoreRequest {
  int id;
  String name;
  List<PosRequest>? listPos;

  StoreRequest({
    required this.id,
    required this.name,
    this.listPos,
  });

  factory StoreRequest.fromJson(Map<String, dynamic> json) => StoreRequest(
        id: json['id'],
        name: json['name'],
        listPos: List<PosRequest>.from(json['cashregisters_inactives'].map((model) => PosRequest.fromJson(model))),
      );
}
