import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:benchmark/benchmark.dart';
import 'package:drift/drift.dart' as drift;
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'constants.dart';
import 'drift_database.dart';
import 'drift_document.dart';

class DriftProvider extends DatabaseProvider<int, DriftDoc> {
  @override
  String get name => databaseName;

  @override
  bool get supportsCurrentPlatform => !Platform.isLinux && !Platform.isWindows;

  @override
  bool supportsParameterArguments(ParameterArguments arguments) =>
      andPredicates([
        anyArgument(execution),
        anyArgument(batchSize),
      ])(arguments);

  @override
  FutureOr<BenchmarkDatabase<int, DriftDoc>> openDatabase(
    String directory,
    ParameterArguments arguments,
  ) async {
    final path = p.join(directory, 'db.sqlite');
    return _createDB(
      path,
      backgroundIsolate: arguments.get(execution)! == Execution.async,
    );
  }
}

Future<DriftDatabase> _createDB(
  String path, {
  required bool backgroundIsolate,
}) async {
  DriftBenchmarkDatabase db;
  DriftIsolate? driftIsolate;

  if (backgroundIsolate) {
    final receivePort = ReceivePort();
    await Isolate.spawn(
      _startBackground,
      _IsolateStartRequest(receivePort.sendPort, path),
    );
    driftIsolate = await receivePort.first as DriftIsolate;
    db = DriftBenchmarkDatabase.connect(await driftIsolate.connect());
  } else {
    db = DriftBenchmarkDatabase(NativeDatabase(File(path)));
  }

  return DriftDatabase(db, onClose: () => driftIsolate?.shutdownAll());
}

void _startBackground(_IsolateStartRequest request) {
  final executor = NativeDatabase(File(request.targetPath));
  final driftIsolate = DriftIsolate.inCurrent(
    () => drift.DatabaseConnection.fromExecutor(executor),
    killIsolateWhenDone: true,
  );
  request.sendDriftIsolate.send(driftIsolate);
}

class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}
