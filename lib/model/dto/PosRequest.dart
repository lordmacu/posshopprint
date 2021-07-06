import 'package:flutter/cupertino.dart';

class PosRequest {
  int id;
  String name;

  PosRequest({
    required this.id,
    required this.name,
  });
  
  factory PosRequest.fromJson(Map<String, dynamic> json) {
    debugPrint('Pos Id: ${json['id']}');
    return PosRequest(
      id: json['id'],
      name: json['name'],
    );
  }
}
