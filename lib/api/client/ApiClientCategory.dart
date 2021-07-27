import 'package:posshop_app/model/dto/CategoriesRequest.dart';
import 'package:posshop_app/model/dto/CategoryRequest.dart';
import 'package:posshop_app/utils/APIManager.dart';

Future<CategoriesRequest> getAll() async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.get('https://poschile.bbndev.com/api/category');
  } catch (e) {
    rethrow;
  }

  return CategoriesRequest.fromJson(body);
}

Future<CategoryRequest> getById(int id) async {
  Map<String, dynamic> body;
  APIManager api = APIManager();
  try {
    body = await api.get('https://poschile.bbndev.com/api/category/$id');
  } catch (e) {
    rethrow;
  }

  return CategoryRequest.fromJsonData(body);
}

Future<void> deleteById(int id) async {
  APIManager api = APIManager();
  try {
    await api.delete('https://poschile.bbndev.com/api/category/$id');
  } catch (e) {
    rethrow;
  }
}
