import 'package:posshop_app/data/dao/ItemDao.dart';
import 'package:posshop_app/api/client/ApiClientItem.dart' as client;
import 'package:posshop_app/model/entity/ItemEntity.dart';

class ItemService {
  final ItemDao _itemDao = ItemDao();

  Future<int> updateAll() async {
    int totalUpdated = 0;

    try {
      await client.getAll().then((itemsRequest) async {
        if (itemsRequest.items != null) {
          await _itemDao.deleteAll().then((value) {
            itemsRequest.items!.forEach((itemRequest) async {
              await _itemDao.insert(ItemEntity.fromRequest(itemRequest));
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

  Future<bool> save(ItemEntity entity) async {
    bool success = false;
    try {
      if (entity.idCloud == 0) {
        await client.create(entity).then((value) {
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

  Future<bool> delete(ItemEntity entity) async {
    bool success = false;
    if (entity.idCloud != 0) {
      await client.delete(entity.idCloud).then((value) {
        success = true;
      });
    }
    return success;
  }
}
