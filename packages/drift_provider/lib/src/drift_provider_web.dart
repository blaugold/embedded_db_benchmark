import 'dart:async';

import 'package:benchmark/benchmark.dart';
import 'package:drift/wasm.dart';
import 'package:http/http.dart' as http;
import 'package:sqlite3/wasm.dart';

import 'constants.dart';
import 'drift_database.dart';
import 'drift_document.dart';

class DriftProvider extends DatabaseProvider<int, DriftDoc> {
  @override
  String get name => databaseName;

  @override
  bool get supportsCurrentPlatform => true;

  @override
  bool supportsParameterArguments(ParameterArguments arguments) =>
      andPredicates([
        anyArgumentOf(execution, [Execution.sync]),
        anyArgument(batchSize),
      ])(arguments);

  @override
  FutureOr<BenchmarkDatabase<int, DriftDoc>> openDatabase(
    String directory,
    ParameterArguments arguments,
  ) async {
    final response = await http.get(Uri.parse('sqlite3.wasm'));
    final fs = await IndexedDbFileSystem.open(dbName: 'drift_benchmark');
    final sqlite3 = await WasmSqlite3.load(
      response.bodyBytes,
      SqliteEnvironment(fileSystem: fs),
    );
    final db = WasmDatabase(sqlite3: sqlite3, path: '/benchmark.db');
    return DriftDatabase(DriftBenchmarkDatabase(db), onClose: fs.clear);
  }
}
