import 'package:posshop_app/data/dao/BaseDao.dart';
import 'package:posshop_app/model/entity/VariantOptionNameEntity.dart';

class VariantOptionNameDao extends BaseDao<VariantOptionNameEntity> {
  static const String STORE_NAME = 'variant_option_name';

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  VariantOptionNameEntity fromMap(Map<String, Object?> map) {
    return VariantOptionNameEntity.fromMap(map);
  }
}
