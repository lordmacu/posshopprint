import 'package:posshop_app/data/dao/ItemDao.dart';
import 'package:posshop_app/api/client/ApiClientItem.dart' as client;
import 'package:posshop_app/data/dao/ItemOutletDao.dart';
import 'package:posshop_app/data/dao/VariantDao.dart';
import 'package:posshop_app/data/dao/VariantOptionNameDao.dart';
import 'package:posshop_app/data/dao/VariantOptionValueDao.dart';
import 'package:posshop_app/model/entity/ItemEntity.dart';
import 'package:posshop_app/model/entity/ItemOutletEntity.dart';
import 'package:posshop_app/model/entity/VariantEntity.dart';
import 'package:posshop_app/model/entity/VariantOptionNameEntity.dart';
import 'package:posshop_app/model/entity/VariantOptionValueEntity.dart';

class ItemService {
  final ItemDao _itemDao = ItemDao();
  final ItemOutletDao _itemOutletDao = ItemOutletDao();
  final VariantDao _variantDao = VariantDao();
  final VariantOptionNameDao _variantOptionNameDao = VariantOptionNameDao();
  final VariantOptionValueDao _variantOptionValueDao = VariantOptionValueDao();

  Future<int> updateAll(int idPos) async {
    int totalUpdated = 0;

    try {
      await client.getAll(idPos).then((itemsRequest) async {
        if (itemsRequest.items != null) {
          await _itemDao.deleteAll().then((value) {
            itemsRequest.items!.forEach((itemRequest) async {
              await _itemDao.insert(ItemEntity.fromRequest(itemRequest));

              if (itemRequest.itemsOutlet != null) {
                itemRequest.itemsOutlet!.forEach((itemOutletRequest) async {
                  await _itemOutletDao.insert(ItemOutletEntity.fromRequest(itemOutletRequest));
                });
              }

              if (itemRequest.variants != null) {
                itemRequest.variants!.forEach((variantRequest) async {
                  await _variantDao.insert(VariantEntity.fromRequest(variantRequest));
                });
              }

              if (itemRequest.variantOptionsNameOutlet != null) {
                itemRequest.variantOptionsNameOutlet!.forEach((variantOptionNameRequest) async {
                  await _variantOptionNameDao.insert(VariantOptionNameEntity.fromRequest(variantOptionNameRequest));

                  if (variantOptionNameRequest.variantOptionsValues != null) {
                    variantOptionNameRequest.variantOptionsValues!.forEach((variantOptionValueRequest) async {
                      await _variantOptionValueDao.insert(VariantOptionValueEntity.fromRequest(variantOptionValueRequest));
                    });
                  }
                });
              }
            });
          });

          totalUpdated = itemsRequest.items!.length;
        }
      });
    } catch (e) {
      rethrow;
    }

    return totalUpdated;
  }

  Future<List<ItemEntity>> getAll() async {
    try {
      return await _itemDao.getAll();
    } catch (e) {
      rethrow;
    }
  }
}
