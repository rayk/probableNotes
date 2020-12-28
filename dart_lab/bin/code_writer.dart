Uri codeUri(String chunk) => Uri.dataFromString('''
import "dart:isolate";
import 'package:dart_lab/dart_lab.dart';

  dynamic _embedded() {
    $chunk
  }
  
  void main(_, SendPort port) {
    var result = _embedded();
    port.send(result);
  }
''', mimeType: 'application/dart');
