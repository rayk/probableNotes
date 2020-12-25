import 'dart:isolate';

Uri _remoteCode(String chunk) => Uri.dataFromString('''
   import "dart:isolate";
   import "package:dart_lab/dart_lab.dart";
  
  void main(_, SendPort port) {
    print('Executing Code Chunk')
    $chunk
  }
  ''', mimeType: 'application/dart');

/// Executes a chuck of code without maintaining any state.
ReceivePort chunkRunner(String codeChunk) {
  final port = ReceivePort();
  Isolate.spawnUri(_remoteCode(codeChunk), [], port.sendPort);
  return port;
}
