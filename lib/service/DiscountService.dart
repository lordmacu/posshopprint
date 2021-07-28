import 'package:posshop_app/data/dao/DiscountDao.dart';
import 'package:posshop_app/api/client/ApiClientDiscount.dart' as client;
import 'package:posshop_app/model/entity/DiscountEntity.dart';

class DiscountService {
  final DiscountDao _discountDao = DiscountDao();

  Future<int> updateAll(int idPos) async {
    int totalUpdated = 0;

    try {
      await client.getAll(idPos).then((discountsRequest) async {
        if (discountsRequest.discounts != null) {
          await _discountDao.deleteAll().then((value) {
            discountsRequest.discounts!.forEach((discountRequest) async {
              await _discountDao.insert(DiscountEntity.fromRequest(discountRequest));
            });
          });

          totalUpdated = discountsRequest.discounts!.length;
        }
      });
    } catch (e) {
      rethrow;
    }

    return totalUpdated;
  }

  Future<List<DiscountEntity>> getAll() async {
    try {
      return await _discountDao.getAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> save(int idPos, DiscountEntity entity) async {
    bool success = false;
    try {
      if (entity.idCloud == 0) {
        await client.create(idPos, entity).then((value) {
          success = true;
        });
      } else {
        await client.update(entity).then((value) {
          success = true;
        });
      }
    } catch (e) {
      rethrow;
    }
    return success;
  }

  Future<bool> delete(DiscountEntity entity) async {
    bool success = false;
    if (entity.idCloud != 0) {
      await client.delete(entity.idCloud).then((value) {
        success = true;
      });
    }
    return success;
  }
}
