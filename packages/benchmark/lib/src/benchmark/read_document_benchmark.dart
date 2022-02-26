import 'dart:async';

import '../benchmark.dart';
import '../benchmark_parameter.dart';
import '../fixture/document.dart';
import '../parameter.dart';

class ReadDocumentBenchmark extends Benchmark {
  @override
  String get name => 'ReadDocument';

  @override
  Iterable<ParameterCombination> get supportedParameterCombinations =>
      ParameterCombination.allCombinations([
        ParameterRange.all(execution),
        ParameterRange.all(dataModel),
        ParameterRange.all(writeBatching),
      ]);

  @override
  BenchmarkRunner createRunner(ParameterCombination parameterCombination) {
    final BenchmarkRunner benchmark;

    switch (parameterCombination.get(execution)!) {
      case Execution.sync:
        if (parameterCombination.get(writeBatching)!) {
          benchmark = _SyncReadManyDocumentBenchmark();
        } else {
          benchmark = _SyncReadOneDocumentBenchmark();
        }
        break;
      case Execution.async:
        if (parameterCombination.get(writeBatching)!) {
          benchmark = _AsyncReadManyDocumentBenchmark();
        } else {
          benchmark = _AsyncReadOneDocumentBenchmark();
        }
        break;
    }

    return benchmark;
  }
}

class _SyncReadOneDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  @override
  Future<void> setup() async {
    await super.setup();

    // ignore: unused_element
    Future<void> insertDoc(BenchmarkDoc doc) {
      throw UnimplementedError();
    }

    // Insert benchmark documents.
  }

  @override
  void executeOperations() {
    throw UnimplementedError();
  }
}

class _AsyncReadOneDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  @override
  Future<void> executeOperations() async {
    throw UnimplementedError();
  }
}

// ignore: unused_element
const _batchSize = 50;

class _SyncReadManyDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  @override
  void executeOperations() {
    throw UnimplementedError();
  }
}

class _AsyncReadManyDocumentBenchmark extends BenchmarkRunner
    with BenchmarkDocumentMixin {
  @override
  Future<void> executeOperations() async {
    throw UnimplementedError();
  }
}
