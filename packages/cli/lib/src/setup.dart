import 'dart:io';

import 'package:benchmark/benchmark.dart';
import 'package:cbl/cbl.dart';
import 'package:cbl_dart/cbl_dart.dart';
import 'package:path/path.dart' as p;

Future<void> setup({bool localCblLibs = false}) async {
  loadDocumentsJson = _loadDocumentsFromFile;

  // await TracingDelegate.install(DevToolsTracing());
  if (localCblLibs) {
    await _initCblWithLocalLibs();
  } else {
    await _initCblWithHostedLibs();
  }

  Database.log.console.level = LogLevel.error;
}

Future<void> _initCblWithHostedLibs() async {
  await CouchbaseLiteDart.init(edition: Edition.enterprise);
}

Future<void> _initCblWithLocalLibs() async {
  await CouchbaseLite.init(
    libraries: LibrariesConfiguration(
      enterpriseEdition: false,
      directory: p.absolute(
        '../../../cbl-dart/packages/cbl_e2e_tests_standalone_dart/lib',
      ),
      cbl: LibraryConfiguration.dynamic(
        'libcblite',
      ),
      cblDart: LibraryConfiguration.dynamic(
        'libcblitedart',
      ),
    ),
  );
}

Future<String> _loadDocumentsFromFile() {
  return File(p.join(
    Directory.current.path,
    '..',
    'benchmark',
    'lib',
    'src',
    'fixture',
    'documents.json',
  )).readAsString();
}
