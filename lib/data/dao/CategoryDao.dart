import 'package:posshop_app/data/dao/BaseDao.dart';
import 'package:posshop_app/model/entity/CategoryEntity.dart';

class CategoryDao extends BaseDao<CategoryEntity> {
  static const String STORE_NAME = 'category';

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  CategoryEntity fromMap(Map<String, Object?> map) {
    return CategoryEntity.fromMap(map);
  }
}
