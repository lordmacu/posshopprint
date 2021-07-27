import 'package:posshop_app/model/dto/TaxesRequest.dart';
import 'package:posshop_app/utils/APIManager.dart';

Future<TaxesRequest> getAll(int idPos) async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.get('https://poschile.bbndev.com/api/taxs-disponibles/?id_cashregister=$idPos');
  } catch (e) {
    rethrow;
  }

  return TaxesRequest.fromJson(body);
}
