import 'package:posshop_app/model/dto/OutletRequest.dart';
import 'package:posshop_app/utils/APIManager.dart';

Future<OutletRequest> get() async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.get('https://poschile.bbndev.com/api/outlets-disponibles');
  } catch (e) {
    rethrow;
  }

  return OutletRequest.fromJson(body);
}
