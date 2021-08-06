import 'package:posshop_app/model/dto/ItemsRequest.dart';
import 'package:posshop_app/model/dto/ItemRequest.dart';
import 'package:posshop_app/model/entity/ItemEntity.dart';
import 'package:posshop_app/utils/APIManager.dart';

Future<ItemsRequest> getAll() async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.get('https://poschile.bbndev.com/api/category');
  } catch (e) {
    rethrow;
  }

  return ItemsRequest.fromJson(body);
}

Future<ItemRequest> create(ItemEntity entity) async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.post(
        'https://poschile.bbndev.com/api/category?name=${entity.name}&color=${entity.color.replaceFirst('#','')}');
  } catch (e) {
    rethrow;
  }

  return ItemRequest.fromJsonData(body);
}

Future<ItemRequest> update(ItemEntity entity) async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.put(
        'https://poschile.bbndev.com/api/category/${entity.idCloud}?name=${entity.name}&color=${entity.color.replaceFirst('#','')}');
  } catch (e) {
    rethrow;
  }

  return ItemRequest.fromJsonData(body);
}

Future<void> delete(int id) async {
  APIManager api = APIManager();
  try {
    await api.delete('https://poschile.bbndev.com/api/category/$id');
  } catch (e) {
    rethrow;
  }
}
