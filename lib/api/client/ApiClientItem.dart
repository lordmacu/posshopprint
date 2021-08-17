import 'package:posshop_app/model/dto/ItemsRequest.dart';
import 'package:posshop_app/utils/APIManager.dart';

Future<ItemsRequest> getAll(int idPos) async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.get('https://poschile.bbndev.com/api/items-disponibles?id_cashregister=$idPos');
  } catch (e) {
    rethrow;
  }

  return ItemsRequest.fromJson(body);
}
