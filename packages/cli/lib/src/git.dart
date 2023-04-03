import 'dart:io';

String currentCommit() {
  final result = Process.runSync('git', ['rev-parse', 'HEAD']);
  if (result.exitCode != 0) {
    throw Exception('Failed to get current commit: ${result.stderr}');
  }
  return result.stdout.toString().trim();
}
