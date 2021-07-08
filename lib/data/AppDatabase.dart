import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../utils/EncryptCodec.dart';

class AppDatabase {
  static const DB_NAME = 'posshop.db';
  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;
  static Database? _database;
  SembastCodec _codec =
      getEncryptSembastCodec(password: 'PosShop2021ByBlubinest');

  AppDatabase._();

  Future<Database> get database async {
    if (_database == null) {
      _database = await _openDatabase();
    }
    return _database!;
  }

  Future _openDatabase() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDir.path, DB_NAME);
    return await databaseFactoryIo.openDatabase(dbPath, codec: _codec);
  }
}
