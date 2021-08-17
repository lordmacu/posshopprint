import 'package:posshop_app/data/dao/BaseDao.dart';
import 'package:posshop_app/model/entity/VariantOptionValueEntity.dart';

class VariantOptionValueDao extends BaseDao<VariantOptionValueEntity> {
  static const String STORE_NAME = 'variant_option_value';

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  VariantOptionValueEntity fromMap(Map<String, Object?> map) {
    return VariantOptionValueEntity.fromMap(map);
  }
}
