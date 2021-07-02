import 'package:flutter/cupertino.dart';

import 'Pos.dart';

class Store {
  int id;
  String name;
  List<Pos>? listPos;

  Store({
    required this.id,
    required this.name,
    this.listPos,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    debugPrint('Store Id: ${json['id']}');
    return Store(
      id: json['id'],
      name: json['name'],
      listPos: List<Pos>.from(json['cashregisters_inactives'].map((model)=> Pos.fromJson(model))),
    );
  }
}
