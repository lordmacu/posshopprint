import 'dart:async';

import 'package:posshop_app/data/AppDatabase.dart';
import 'package:posshop_app/model/entity/BaseEntity.dart';
import 'package:sembast/sembast.dart';

abstract class BaseDao<T extends BaseEntity> {
  late StoreRef<int, Map<String, Object?>> _store;

  Future<Database> get _db async => await AppDatabase.instance.database;

  String getStoreName();

  T fromMap(Map<String, Object?> map);

  BaseDao() {
    _store = intMapStoreFactory.store(getStoreName());
  }

  Future<int> insert(T entity) async {
    return await _store.add(await _db, entity.toMap());
  }

  Future<int> update(T entity) async {
    final finder = Finder(filter: Filter.byKey(entity.id));
    return await _store.update(
      await _db,
      entity.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(T entity) async {
    final finder = Finder(filter: Filter.byKey(entity.id));
    return await _store.delete(
      await _db,
      finder: finder,
    );
  }

  Future<int> deleteAll() async {
    return await _store.delete(await _db);
  }

  Future<T?> findById(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final recordSnapshots = await _store.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.isEmpty ? null : fromMap(recordSnapshots.first.value);
  }

  Future<List<T>> getAll() async {
    final recordSnapshots = await _store.find(
      await _db,
    );

    return recordSnapshots.map((snapshot) {
      final T _entity = fromMap(snapshot.value);
      _entity.id = snapshot.key;
      return _entity;
    }).toList();
  }
}
