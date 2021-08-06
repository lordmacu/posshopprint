import 'ItemRequest.dart';

class ItemsRequest {
  List<ItemRequest>? items;

  ItemsRequest({
    this.items,
  });

  factory ItemsRequest.fromJson(Map<String, dynamic> json) {
    return ItemsRequest(
      items: List<ItemRequest>.from(
          json['data'].map((model) => ItemRequest.fromJson(model))),
    );
  }
}
