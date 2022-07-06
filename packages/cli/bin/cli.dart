// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli/src/runner.dart';

Future<void> main(List<String> args) async {
  try {
    await EdbRunner().run(args);
  } on UsageException catch (e) {
    exitCode = 1;
    print(e);
  } catch (e, s) {
    exitCode = 1;
    print('Internal error: $e');
    print(s);
  }

  // Force exit, in case some database is leaking resources that keep the
  // isolate running.
  exit(exitCode);
}
