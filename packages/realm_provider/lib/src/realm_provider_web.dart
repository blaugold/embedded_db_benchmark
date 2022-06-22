import 'package:benchmark/benchmark.dart';

import 'constants.dart';

class RealmProvider extends UnsupportedProvider {
  RealmProvider() : super(databaseName);
}
