import 'dart:io';

bool get hasTerminal => stdout.hasTerminal;

void stdoutWrite(String value) => stdout.write(value);

String createTempDir() => Directory.systemTemp.createTempSync().path;

Future<void> deleteDirectory(String path) =>
    Directory(path).delete(recursive: true);
