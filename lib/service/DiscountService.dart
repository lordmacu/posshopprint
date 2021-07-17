import 'package:flutter/cupertino.dart';
import 'package:posshop_app/data/dao/DiscountDao.dart';
import 'package:posshop_app/api/client/ApiClientDiscount.dart' as client;
import 'package:posshop_app/model/entity/DiscountEntity.dart';

class DiscountService {
  DiscountDao _discountDao = DiscountDao();

  updateAll() {
    //TODO: Cambiar ese 2.
    client.getAll(2).then((discountsRequest) {
      if (discountsRequest.discounts != null) {
        discountsRequest.discounts!.forEach((discountRequest) {
          debugPrint('Request, Nombre de descuento ${discountRequest.name}');
        });
      }

      _discountDao.getAll().then((discounts) {
        discounts.forEach((discount) {
          debugPrint('Dao, Nombre del descuento ${discount.name}');
        });
      });
    }); //TODO: Cambiar.
  }

  insert(DiscountEntity entity) {
    _discountDao.insert(entity);
  }
}
