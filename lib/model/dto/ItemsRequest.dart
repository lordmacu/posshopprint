import 'ItemRequest.dart';

class ItemsRequest {
  int? idOutlet;
  List<ItemRequest>? items;

  ItemsRequest({
    this.idOutlet,
    this.items,
  });

  factory ItemsRequest.fromJson(Map<String, dynamic> json) {
    return ItemsRequest(
      idOutlet: json['data']['idOutlet'],
      items: List<ItemRequest>.from(json['data']['items'].map((model) => ItemRequest.fromJson(model))),
    );
  }
}
