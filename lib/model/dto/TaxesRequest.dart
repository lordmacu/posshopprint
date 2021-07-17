import 'TaxRequest.dart';

class TaxesRequest {
  List<TaxRequest>? taxes;

  TaxesRequest({
    this.taxes,
  });

  factory TaxesRequest.fromJson(Map<String, dynamic> json) {
    return TaxesRequest(
      taxes: List<TaxRequest>.from(
          json['data'].map((model) => TaxRequest.fromJson(model))),
    );
  }
}
