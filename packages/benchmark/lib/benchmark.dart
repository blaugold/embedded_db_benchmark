import 'src/benchmark/read_document.dart' as read_document;
import 'src/benchmark/write_document.dart' as write_document;

export 'src/fixture/document_utils.dart' show loadDocumentsJson;

const writeDocument = write_document.runBenchmarks;
const readDocument = read_document.runBenchmarks;
