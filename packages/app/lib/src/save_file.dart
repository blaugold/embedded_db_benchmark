import 'package:flutter/services.dart';

final _channel = MethodChannel('net.terwesten.gabriel.edb.app/file_selector');

class FileSelectorPlugin {
  FileSelectorPlugin._();

  static final instance = FileSelectorPlugin._();

   Future<void> saveFile({
    required String title,
    required String contentType,
    required Uint8List data,
  }) {
    return _channel.invokeMethod('saveFile', {
      'title': title,
      'contentType': contentType,
      'data': data,
    });
  }
}
