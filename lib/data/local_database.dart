/// Use local_database whenever you need to stream a database locally

import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

Future<Database> getDb() async {
  final pathRoot = await getApplicationDocumentsDirectory();
  final dbPath = pathRoot.path + '/mymgs_sembast.db';
  final dbFactory = databaseFactoryIo;
  return dbFactory.openDatabase(dbPath);
}
