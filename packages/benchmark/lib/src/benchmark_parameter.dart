import 'parameter.dart';

enum Execution {
  sync,
  async,
}

final execution = EnumParameter('execution', Execution.values);

final batchSize = NumericParameter<int>('batch-size', min: 1);
