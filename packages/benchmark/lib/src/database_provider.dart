import 'dart:async';

import 'benchmark_database.dart';
import 'benchmark_document.dart';
import 'parameter.dart';

abstract class DatabaseProvider<ID extends Object, T extends BenchmarkDoc<ID>> {
  /// The display name of the Database.
  ///
  /// Currently this is also used for serialization of results and must
  /// therefore be stable.
  String get name;

  /// Whether this provider supports the current platform.
  bool get supportsCurrentPlatform;

  bool supportsParameterArguments(ParameterArguments arguments);

  FutureOr<BenchmarkDatabase<ID, T>> openDatabase(
    String directory,
    ParameterArguments arguments,
  );

  R runWith<R>(
    R Function<ID extends Object, T extends BenchmarkDoc<ID>>(
      DatabaseProvider<ID, T>,
    ) fn,
  ) =>
      fn<ID, T>(this);

  @override
  String toString() => 'DatabaseProvider($name)';
}

class UnsupportedProvider extends DatabaseProvider {
  UnsupportedProvider(this.name);

  @override
  final String name;

  @override
  bool get supportsCurrentPlatform => false;

  @override
  bool supportsParameterArguments(ParameterArguments arguments) => false;

  @override
  FutureOr<BenchmarkDatabase> openDatabase(
    String directory,
    ParameterArguments arguments,
  ) {
    throw UnimplementedError();
  }
}
