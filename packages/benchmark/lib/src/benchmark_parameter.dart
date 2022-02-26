import 'parameter.dart';

enum Execution {
  sync,
  async,
}

final execution = EnumParameter(Execution.values);

enum DataModel {
  static,
  dynamic,
}

final dataModel = EnumParameter(DataModel.values);

final writeBatching = FlagParameter('write-batching');

