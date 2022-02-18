import 'dart:io';

import 'package:benchmark/benchmark.dart';

import 'setup.dart';

Future<void> runBenchmarks() async {
  await setup();

  await writeDocument(
    withRealm: !Platform.isLinux,
    withObjectBox: !Platform.isMacOS,
  );
  await readDocument(
    withRealm: !Platform.isLinux,
    withObjectBox: !Platform.isMacOS,
  );
}
