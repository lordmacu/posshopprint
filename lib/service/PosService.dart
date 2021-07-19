import 'package:posshop_app/data/dao/PosDao.dart';

class PosService {
  final PosDao _posDao = PosDao();

  Future<int?> getPosId() async {
    int? posId;
    await _posDao.getAll().then((poses) {
      if (poses.isNotEmpty) {
        posId = poses.first.posId;
      }
    });
    return posId;
  }
}
