/// Use local_database whenever you need to stream a database locally

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class _DbSingleton {
  _DbSingleton._();
  static _DbSingleton _singleton = _DbSingleton._();
  factory _DbSingleton() => _singleton;

  Database? _database;
  Future<Database> getDb() async {
    final _db = _database;
    if (_db != null) {
      return _db;
    } else {
      if (kIsWeb) {
        _database = await databaseFactoryWeb.openDatabase('mymgs_sembast');
      } else {
        final pathRoot = await getApplicationDocumentsDirectory();
        final dbPath = pathRoot.path + '/mymgs_sembast.db';
        final dbFactory = databaseFactoryIo;
        _database = await dbFactory.openDatabase(dbPath);
      }

      return _database!;
    }
  }
}

Future<Database> getDb() async {
  return _DbSingleton().getDb();
}
