import 'dart:io';
import 'dart:isolate';

import 'code_writer.dart';

/// Main external chunk execution point dart_lab.
///
///

main(List<String> chunk) {
  final port = ReceivePort();
  final sb = StringBuffer();
  chunk.forEach((element) => sb.writeln(element));
  var code = codeUri(sb.toString());

  Isolate.spawnUri(code, [], port.sendPort).then((Isolate value) {
    port.listen((message) {
      stdout.writeln(message);
      value.kill();
      port.close();
    });
  });
}
