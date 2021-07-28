import 'CategoryService.dart';
import 'DiscountService.dart';
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

      return true;
    }

    return false;
  }
}
