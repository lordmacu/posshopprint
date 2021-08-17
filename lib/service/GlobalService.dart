import 'CategoryService.dart';
import 'DiscountService.dart';
import 'ItemService.dart';
import 'PosService.dart';

class GlobalService {
  Future<bool> loadAll() async {
    PosService posService = PosService();
    int? idPos = await posService.getPosId();

    if (idPos != null) {
      DiscountService discountService = DiscountService();
      await discountService.updateAll(idPos);

      CategoryService categoryService = CategoryService();
      await categoryService.updateAll();

      ItemService itemService = ItemService();
      await itemService.updateAll(idPos);

      return true;
    }

    return false;
  }
}
