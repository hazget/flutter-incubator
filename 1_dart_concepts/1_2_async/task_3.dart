import 'dart:io';
import 'dart:convert';

Future<void> handleWriteRequest(HttpRequest request) async {
  final file = File('dummy.txt');
  final content = await utf8.decoder.bind(request).join();
  await file.writeAsString(content);

  request.response.statusCode = HttpStatus.ok;
  request.response.write('File written successfully');
  await request.response.close();
}

Future<void> handleReadRequest(HttpRequest request) async {
  final file = File('dummy.txt');
  if (!await file.exists()) {
    request.response.statusCode = HttpStatus.notFound;
    request.response.write('File not found');
    await request.response.close();
    return;
  }

  final content = await file.readAsString();
  request.response.statusCode = HttpStatus.ok;
  request.response.write(content);
  await request.response.close();
}

void main() async {
  final server = await HttpServer.bind('localhost', 0);
  print('Server listening on localhost:${server.port}');

  await for (var request in server) {
    if (request.method == 'POST' && request.uri.path == '/write') {
      await handleWriteRequest(request);
    } else if (request.method == 'GET' && request.uri.path == '/read') {
      await handleReadRequest(request);
    } else {
      request.response.statusCode = HttpStatus.notFound;
      request.response.write('Not found');
      await request.response.close();
    }
  }
}
