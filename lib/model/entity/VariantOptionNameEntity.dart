import 'package:posshop_app/model/dto/VariantOptionNameRequest.dart';

import 'BaseEntity.dart';

class VariantOptionNameEntity extends BaseEntity {
  int idCloud;
  int idItem;
  int currentIndex;
  String optionName;

  VariantOptionNameEntity({
    int? id,
    required this.idCloud,
    required this.idItem,
    required this.currentIndex,
    required this.optionName,
  });

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'idCloud': idCloud,
        'idItem': idItem,
        'currentIndex': currentIndex,
        'optionName': optionName,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return VariantOptionNameEntity.fromMap(map);
  }

  factory VariantOptionNameEntity.fromMap(Map<String, dynamic> map) => VariantOptionNameEntity(
        id: map['id'],
        idCloud: map['idCloud'],
        idItem: map['idItem'],
        currentIndex: map['currentIndex'],
        optionName: map['optionName'],
      );

  factory VariantOptionNameEntity.fromRequest(VariantOptionNameRequest request) => VariantOptionNameEntity(
        idCloud: request.id,
        idItem: request.idItem,
        currentIndex: request.currentIndex,
        optionName: request.optionName,
      );

  @override
  String uniqueCloudKey() {
    return idCloud.toString();
  }
}
