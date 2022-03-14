import 'parameter.dart';

enum Execution {
  sync,
  async,
}

final execution = EnumParameter('execution', Execution.values);

enum DataModel {
  static,
  dynamic,
}

final batchSize = ListParameter('batch-size', [1, 100, 1000]);
