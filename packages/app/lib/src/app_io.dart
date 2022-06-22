import 'package:cbl/cbl.dart';
import 'package:cbl_flutter/cbl_flutter.dart';

Future<void> initDatabasePlugins() async {
  await CouchbaseLiteFlutter.init();
  Database.log.custom?.level = LogLevel.error;
}
