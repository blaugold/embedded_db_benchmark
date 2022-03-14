import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';

import '../benchmark_database.dart';
import '../parameter.dart';

abstract class DatabaseProvider<T extends BenchmarkDoc> {
  R runWith<R>(R Function<T extends BenchmarkDoc>(DatabaseProvider<T>) fn) =>
      fn<T>(this);

  String get name;

  Iterable<ParameterCombination> get supportedParameterCombinations;

  bool supportsParameterCombination(ParameterCombination combination) =>
      supportedParameterCombinations.any(
        (supportedCombination) =>
            supportedCombination.containsCombination(combination),
      );

  FutureOr<BenchmarkDatabase<T>> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  );
}
