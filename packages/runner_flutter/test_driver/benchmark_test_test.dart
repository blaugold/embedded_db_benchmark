import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';
import 'package:path/path.dart' as p;

Future<void> main() =>
    integrationDriver(responseDataCallback: (responseData) async {
      final resultsFileName =
          responseData!['benchmark_results_filename']! as String;
      final results = responseData['benchmark_results']! as String;
      final resultsFile = File(p.join(Directory.current.path, resultsFileName));
      await resultsFile.writeAsString(results);
    });
