import 'create_document_benchmark.dart';
import 'delete_document_benchmark.dart';
import 'read_document_benchmark.dart';
import 'update_document_benchmark.dart';

const allBenchmarks = [
  CreateDocumentBenchmark(),
  ReadDocumentBenchmark(),
  UpdateDocumentBenchmark(),
  DeleteDocumentBenchmark(),
];
