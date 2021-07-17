import 'package:posshop_app/model/entity/PosEntity.dart';

import 'BaseDao.dart';

class PosDao extends BaseDao<PosEntity> {
  static const String STORE_NAME = 'pos';

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  PosEntity fromMap(Map<String, Object?> map) {
    return PosEntity.fromMap(map);
  }
}
