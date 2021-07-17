import 'package:posshop_app/data/dao/BaseDao.dart';
import 'package:posshop_app/model/entity/DiscountEntity.dart';

class DiscountDao extends BaseDao<DiscountEntity> {
  static const String STORE_NAME = 'discount';

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  DiscountEntity fromMap(Map<String, Object?> map) {
    return DiscountEntity.fromMap(map);
  }
}
