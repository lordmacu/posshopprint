import 'package:flutter/cupertino.dart';

class Pos {
  int id;
  String name;

  Pos({
    required this.id,
    required this.name,
  });
  
  factory Pos.fromJson(Map<String, dynamic> json) {
    debugPrint('Pos Id: ${json['id']}');
    return Pos(
      id: json['id'],
      name: json['name'],
    );
  }
}
