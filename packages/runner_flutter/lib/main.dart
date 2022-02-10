import 'package:flutter/material.dart';

import 'run_benchmarks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await runBenchmarks();
}
