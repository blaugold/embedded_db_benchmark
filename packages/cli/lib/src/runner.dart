import 'package:args/command_runner.dart';

import 'run_command.dart';

class EdbRunner extends CommandRunner<void> {
  EdbRunner() : super('edb', 'Benchmark embedded databases for use with Dart') {
    addCommand(RunCommand());
  }
}
