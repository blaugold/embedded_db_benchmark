import 'package:benchmark/benchmark.dart';

import 'setup.dart';

Future<void> runBenchmarks() async {
  await setup();

  await writeDocument();
  await readDocument();
}
