import 'package:posshop_app/model/dto/VariantOptionValueRequest.dart';

import 'BaseEntity.dart';

class VariantOptionValueEntity extends BaseEntity {
  int idCloud;
  int idVariantOption;
  String optionValue;

  VariantOptionValueEntity({
    int? id,
    required this.idCloud,
    required this.idVariantOption,
    required this.optionValue,
  });

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'idCloud': idCloud,
        'idVariantOption': idVariantOption,
        'optionValue': optionValue,
      };

  @override
  BaseEntity fromMap(Map<String, dynamic> map) {
    return VariantOptionValueEntity.fromMap(map);
  }

  factory VariantOptionValueEntity.fromMap(Map<String, dynamic> map) => VariantOptionValueEntity(
        id: map['id'],
        idCloud: map['idCloud'],
        idVariantOption: map['idVariantOption'],
        optionValue: map['optionValue'],
      );

  factory VariantOptionValueEntity.fromRequest(VariantOptionValueRequest request) => VariantOptionValueEntity(
        idCloud: request.id,
        idVariantOption: request.idVariantOption,
        optionValue: request.optionValue,
      );

  @override
  String uniqueCloudKey() {
    return idCloud.toString();
  }
}
