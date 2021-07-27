import 'package:posshop_app/model/dto/ClientsRequest.dart';
import 'package:posshop_app/utils/APIManager.dart';

Future<ClientsRequest> getAll() async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.get('https://poschile.bbndev.com/api/client');
  } catch (e) {
    rethrow;
  }

  return ClientsRequest.fromJson(body);
}
