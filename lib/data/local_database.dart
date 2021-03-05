/// Use local_database whenever you need to stream a database locally

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

Future<Database> getDb() async {
  if (kIsWeb) {
    return databaseFactoryWeb.openDatabase('mymgs_sembast');
  } else {
    final pathRoot = await getApplicationDocumentsDirectory();
    final dbPath = pathRoot.path + '/mymgs_sembast.db';
    final dbFactory = databaseFactoryIo;
    return dbFactory.openDatabase(dbPath);
  }
}
