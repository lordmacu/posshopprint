import 'package:posshop_app/data/dao/DiscountDao.dart';
import 'package:posshop_app/api/client/ApiClientDiscount.dart' as client;
import 'package:posshop_app/model/entity/DiscountEntity.dart';

class DiscountService {
  final DiscountDao _discountDao = DiscountDao();

  Future<int> updateAll(int idPos) async {
    int totalUpdated = 0;

    await client.getAll(idPos).then((discountsRequest) {
      if (discountsRequest.discounts != null) {
        _discountDao.deleteAll().then((value) {
          discountsRequest.discounts!.forEach((discountRequest) {
            DiscountEntity entity = DiscountEntity(
              id: discountRequest.id,
              name: discountRequest.name,
              calculationType: discountRequest.calculationType,
              value: discountRequest.value,
            );
            _discountDao.insert(entity);
          });
        });

        totalUpdated = discountsRequest.discounts!.length;
      }
    });

    return totalUpdated;
  }

  Future<List<DiscountEntity>> getAll() {
    return _discountDao.getAll();
  }

  Future<void> insert(DiscountEntity entity) {
    return _discountDao.insert(entity);
  }
}
