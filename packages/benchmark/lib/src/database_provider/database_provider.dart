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

  bool supportsParameterArguments(ParameterArguments arguments);

  FutureOr<BenchmarkDatabase<ID, T>> openDatabase(
    String directory,
    ParameterArguments arguments,
  );
}
