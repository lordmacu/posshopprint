import 'package:posshop_app/model/dto/ProvincesRequest.dart';
import 'package:posshop_app/utils/APIManager.dart';

Future<ProvincesRequest> getAll() async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.get('https://poschile.bbndev.com/api/comuna');
  } catch (e) {
    rethrow;
  }

  return ProvincesRequest.fromJson(body);
}
