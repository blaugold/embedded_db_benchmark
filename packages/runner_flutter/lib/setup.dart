import 'package:benchmark/benchmark.dart';
import 'package:cbl/cbl.dart';
import 'package:cbl_flutter/cbl_flutter.dart';
import 'package:flutter/services.dart';

Future<void> setup() async {
  loadDocumentsJson = _loadDocumentsFromAssets;

  await CouchbaseLiteFlutter.init();
  Database.log.custom?.level = LogLevel.error;
}

Future<String> _loadDocumentsFromAssets() =>
    rootBundle.loadString('packages/benchmark/src/fixture/documents.json');
