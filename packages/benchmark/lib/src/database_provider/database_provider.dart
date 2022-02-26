import 'dart:async';

import '../benchmark_database.dart';
import '../parameter.dart';

abstract class DatabaseProvider {
  String get name;

  Iterable<ParameterCombination> get supportedParameterCombinations;

  bool supportsParameterCombination(ParameterCombination combination) =>
      supportedParameterCombinations.any(
        (supportedCombination) =>
            supportedCombination.containsCombination(combination),
      );

  FutureOr<BenchmarkDatabase> openDatabase(
    String directory,
    ParameterCombination parameterCombination,
  );
}
