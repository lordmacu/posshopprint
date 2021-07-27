import 'package:posshop_app/model/dto/DiscountRequest.dart';
import 'package:posshop_app/model/dto/DiscountsRequest.dart';
import 'package:posshop_app/model/entity/DiscountEntity.dart';
import 'package:posshop_app/utils/APIManager.dart';

Future<DiscountsRequest> getAll(int idPos) async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.get('https://poschile.bbndev.com/api/discount/?id_cashregister=$idPos');
  } catch (e) {
    rethrow;
  }

  return DiscountsRequest.fromJson(body);
}

Future<DiscountRequest> create(int idPos, DiscountEntity entity) async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.post(
        'https://poschile.bbndev.com/api/discount?id_cashregister=$idPos&name=${entity.name}&calculationType=${entity.calculationType}${entity.value != null ? '&value=' + entity.value.toString().replaceAll(',', '.') : ''}');
  } catch (e) {
    rethrow;
  }

  return DiscountRequest.fromJsonData(body);
}

Future<DiscountRequest> update(DiscountEntity entity) async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.put(
        'https://poschile.bbndev.com/api/discount/${entity.idCloud}?name=${entity.name}&calculationType=${entity.calculationType}${entity.value != null ? '&value=' + entity.value.toString().replaceAll(',', '.') : ''}');
  } catch (e) {
    rethrow;
  }

  return DiscountRequest.fromJsonData(body);
}

Future<void> delete(int id) async {
  APIManager api = APIManager();
  try {
    await api.delete('https://poschile.bbndev.com/api/discount/$id');
  } catch (e) {
    rethrow;
  }
}
