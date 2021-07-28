import 'package:posshop_app/data/dao/CategoryDao.dart';
import 'package:posshop_app/api/client/ApiClientCategory.dart' as client;
import 'package:posshop_app/model/entity/CategoryEntity.dart';

class CategoryService {
  final CategoryDao _categoryDao = CategoryDao();

  Future<int> updateAll() async {
    int totalUpdated = 0;

    try {
      await client.getAll().then((categoriesRequest) async {
        if (categoriesRequest.categories != null) {
          await _categoryDao.deleteAll().then((value) {
            categoriesRequest.categories!.forEach((categoryRequest) async {
              await _categoryDao.insert(CategoryEntity.fromRequest(categoryRequest));
            });
          });

          totalUpdated = categoriesRequest.categories!.length;
        }
      });
    } catch (e) {
      rethrow;
    }

    return totalUpdated;
  }

  Future<List<CategoryEntity>> getAll() async {
    try {
      return await _categoryDao.getAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> save(CategoryEntity entity) async {
    bool success = false;
    try {
      if (entity.idCloud == 0) {
        await client.create(entity).then((value) {
          success = true;
        });
      } else {
        await client.update(entity).then((value) {
          success = true;
        });
      }
    } catch (e) {
      rethrow;
    }
    return success;
  }

  Future<bool> delete(CategoryEntity entity) async {
    bool success = false;
    if (entity.idCloud != 0) {
      await client.delete(entity.idCloud).then((value) {
        success = true;
      });
    }
    return success;
  }
}
