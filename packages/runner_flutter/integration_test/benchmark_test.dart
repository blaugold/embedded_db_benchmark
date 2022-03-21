import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:runner_flutter/main.dart' as runner_flutter;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('run benchmarks', (_) async {
    final benchmarkResults = await runner_flutter.main();
    final reportData =
        (WidgetsBinding.instance as IntegrationTestWidgetsFlutterBinding)
            .reportData ??= <String, dynamic>{};
    reportData.addAll(benchmarkResults);
  });
}
