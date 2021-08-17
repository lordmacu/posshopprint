import 'package:posshop_app/data/dao/BaseDao.dart';
import 'package:posshop_app/model/entity/VariantEntity.dart';

class VariantDao extends BaseDao<VariantEntity> {
  static const String STORE_NAME = 'variant';

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  VariantEntity fromMap(Map<String, Object?> map) {
    return VariantEntity.fromMap(map);
  }
}
