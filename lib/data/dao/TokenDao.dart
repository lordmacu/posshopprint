import 'package:posshop_app/model/entity/TokenEntity.dart';

import 'BaseDao.dart';

class TokenDao extends BaseDao<TokenEntity> {
  static const String STORE_NAME = 'token';

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  TokenEntity fromMap(Map<String, Object?> map) {
    return TokenEntity.fromMap(map);
  }
}
