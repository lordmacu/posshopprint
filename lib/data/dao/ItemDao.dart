import 'package:posshop_app/data/dao/BaseDao.dart';
import 'package:posshop_app/model/entity/ItemEntity.dart';

class ItemDao extends BaseDao<ItemEntity> {
  static const String STORE_NAME = 'item';

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  ItemEntity fromMap(Map<String, Object?> map) {
    return ItemEntity.fromMap(map);
  }
}
