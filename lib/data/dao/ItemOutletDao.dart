import 'package:posshop_app/data/dao/BaseDao.dart';
import 'package:posshop_app/model/entity/ItemOutletEntity.dart';

class ItemOutletDao extends BaseDao<ItemOutletEntity> {
  static const String STORE_NAME = 'item_outlet';

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  ItemOutletEntity fromMap(Map<String, Object?> map) {
    return ItemOutletEntity.fromMap(map);
  }
}
