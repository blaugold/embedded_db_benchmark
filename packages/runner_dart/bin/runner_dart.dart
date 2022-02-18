import 'package:benchmark/benchmark.dart';

import 'setup.dart';

Future<void> main() async {
  await setup();

  await writeDocument(withIsar: false);
  await readDocument(withIsar: false);
}
