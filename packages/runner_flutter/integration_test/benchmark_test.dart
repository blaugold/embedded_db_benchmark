import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:runner_flutter/main.dart' as runner_flutter;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('run benchmarks', (_) => runner_flutter.main());
}
