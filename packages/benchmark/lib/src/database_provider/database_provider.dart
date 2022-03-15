import 'dart:async';

import 'package:benchmark_document/benchmark_document.dart';

import '../benchmark_database.dart';
import '../parameter.dart';

abstract class DatabaseProvider<ID extends Object, T extends BenchmarkDoc<ID>> {
  R runWith<R>(
    R Function<ID extends Object, T extends BenchmarkDoc<ID>>(
      DatabaseProvider<ID, T>,
    )
        fn,
  ) =>
      fn<ID, T>(this);

  String get name;

  Iterable<ParameterCombination> get supportedParameterCombinations;

  bool supportsParameterCombination(ParameterCombination combination) =>
      supportedParameterCombinations.any(
        (supportedCombination) =>
            supportedCombination.containsCombination(combination),
      );

  FutureOr<BenchmarkDatabase<ID, T>> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  );
}
