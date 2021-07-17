import 'ProvinceRequest.dart';

class ProvincesRequest {
  List<ProvinceRequest>? provinces;

  ProvincesRequest({
    this.provinces,
  });

  factory ProvincesRequest.fromJson(Map<String, dynamic> json) {
    return ProvincesRequest(
      provinces: List<ProvinceRequest>.from(
          json['data'].map((model) => ProvinceRequest.fromJson(model))),
    );
  }
}
