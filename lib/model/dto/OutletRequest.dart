import 'StoreRequest.dart';

class OutletRequest {
  List<StoreRequest>? stores;

  OutletRequest({
    this.stores,
  });

  factory OutletRequest.fromJson(Map<String, dynamic> json) {
    return OutletRequest(
      stores: List<StoreRequest>.from(json['data'].map((model) => StoreRequest.fromJson(model))),
    );
  }
}
