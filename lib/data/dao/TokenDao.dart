import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:posshop_app/data/AppDatabase.dart';
import 'package:posshop_app/model/db/TokenDB.dart';
import 'package:sembast/sembast.dart';

class TokenDao {
  static const String STORE_NAME = 'token';
  final _store = intMapStoreFactory.store(STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(TokenDB token) async {
    await _store.add(await _db, token.toMap());
  }

  Future update(TokenDB token) async {
    final finder = Finder(filter: Filter.byKey(token.id));
    await _store.update(
      await _db,
      token.toMap(),
      finder: finder,
    );
  }

  Future delete(TokenDB token) async {
    final finder = Finder(filter: Filter.byKey(token.id));
    await _store.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<TokenDB>> getAll() async {
    debugPrint('mensaje 1 ${_db.toString()}');
    final recordSnapshots = await _store.find(
      await _db,
    );

    debugPrint('mensaje 2 ${_db.toString()}');
    return recordSnapshots.map((snapshot) {
      final token = TokenDB.fromMap(snapshot.value);
      token.id = snapshot.key;
      return token;
    }).toList();
  }
}
