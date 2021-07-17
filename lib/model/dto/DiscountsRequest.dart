import 'DiscountRequest.dart';

class DiscountsRequest {
  List<DiscountRequest>? discounts;

  DiscountsRequest({
    this.discounts,
  });

  factory DiscountsRequest.fromJson(Map<String, dynamic> json) {
    return DiscountsRequest(
      discounts: List<DiscountRequest>.from(
          json['data'].map((model) => DiscountRequest.fromJson(model))),
    );
  }
}
