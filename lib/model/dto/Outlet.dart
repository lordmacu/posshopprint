import 'Store.dart';

class Outlet {
  List<Store>? stores;

  Outlet({
    this.stores,
  });

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
      stores: List<Store>.from(json['data'].map((model)=> Store.fromJson(model))),
    );
  }
}
