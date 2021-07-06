import 'dart:async';

import 'package:posshop_app/data/AppDatabase.dart';
import 'package:posshop_app/model/db/PosDB.dart';
import 'package:sembast/sembast.dart';

class PosDao {
  static const String STORE_NAME = 'pos';
  final _store = intMapStoreFactory.store(STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(PosDB pos) async {
    await _store.add(await _db, pos.toMap());
  }

  Future update(PosDB pos) async {
    final finder = Finder(filter: Filter.byKey(pos.id));
    await _store.update(
      await _db,
      pos.toMap(),
      finder: finder,
    );
  }

  Future delete(PosDB pos) async {
    final finder = Finder(filter: Filter.byKey(pos.id));
    await _store.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<PosDB>> getAll() async {
    final recordSnapshots = await _store.find(
      await _db,
    );

    return recordSnapshots.map((snapshot) {
      final pos = PosDB.fromMap(snapshot.value);
      pos.id = snapshot.key;
      return pos;
    }).toList();
  }
}
