import 'dart:isolate';

Uri _remoteCode(String chunk) => Uri.dataFromString('''
   import "dart:isolate";
  
  void main(_, SendPort port) {
    print('Executing Code Chunk')
    $chunk
  }
  ''', mimeType: 'application/dart');

ReceivePort chunkRunner(String codeChunk) {
  final port = ReceivePort();
  Isolate.spawnUri(_remoteCode(codeChunk), [], port.sendPort);
  return port;
}
