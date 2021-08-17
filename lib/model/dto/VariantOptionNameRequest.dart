import 'VariantOptionValueRequest.dart';

class VariantOptionNameRequest {
  int id;
  int idItem;
  int currentIndex;
  String optionName;
  List<VariantOptionValueRequest>? variantOptionsValues;

  VariantOptionNameRequest({
    required this.id,
    required this.idItem,
    required this.currentIndex,
    required this.optionName,
    this.variantOptionsValues,
  });

  factory VariantOptionNameRequest.fromJson(Map<String, dynamic> json) {
    return VariantOptionNameRequest(
      id: json['id'],
      idItem: json['idItem'],
      currentIndex: json['currentIndex'],
      optionName: json['optionName'],
      variantOptionsValues: (json['variant_option_values'] != null)
          ? List<VariantOptionValueRequest>.from(
              json['variant_option_values'].map((model) => VariantOptionValueRequest.fromJson(model)))
          : null,
    );
  }

  factory VariantOptionNameRequest.fromJsonWithIdItem(Map<String, dynamic> json, int idItem) {
    return VariantOptionNameRequest(
      id: json['id'],
      idItem: idItem,
      currentIndex: json['currentIndex'],
      optionName: json['optionName'],
      variantOptionsValues: (json['variant_option_values'] != null)
          ? List<VariantOptionValueRequest>.from(
          json['variant_option_values'].map((model) => VariantOptionValueRequest.fromJson(model)))
          : null,
    );
  }

  factory VariantOptionNameRequest.fromJsonData(Map<String, dynamic> json) {
    return VariantOptionNameRequest.fromJson(json['data']);
  }
}
