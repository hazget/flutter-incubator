import 'dart:convert';
import 'dart:io';

void main() async {
  final server = await HttpServer.bind('127.0.0.1', 8080);
  print('Server running on ${server.address}:${server.port}');

  await for (var request in server) {
    if (request.method == 'POST') {
      // Handle POST request to write to dummy.txt
      await handleWriteRequest(request);
    } else if (request.method == 'GET') {
      // Handle GET request to read from dummy.txt
      await handleReadRequest(request);
    } else {
      // Respond with Method Not Allowed for other request types
      request.response
        ..statusCode = HttpStatus.methodNotAllowed
        ..write('Method Not Allowed')
        ..close();
    }
  }
}

Future<void> handleWriteRequest(HttpRequest request) async {
  try {
    // Read the request body
    final body = await utf8.decoder.bind(request).join();
    // Write to dummy.txt
    await File('dummy.txt').writeAsString(body);
    // Respond with success
    request.response
      ..statusCode = HttpStatus.ok
      ..write('Data written to dummy.txt')
      ..close();
  } catch (e) {
    // Respond with Internal Server Error if an error occurs
    request.response
      ..statusCode = HttpStatus.internalServerError
      ..write('Internal Server Error')
      ..close();
  }
}

Future<void> handleReadRequest(HttpRequest request) async {
  try {
    // Read from dummy.txt
    final content = await File('dummy.txt').readAsString();
    // Respond with the file contents
    request.response
      ..statusCode = HttpStatus.ok
      ..write(content)
      ..close();
  } catch (e) {
    // Respond with Not Found if dummy.txt does not exist
    request.response
      ..statusCode = HttpStatus.notFound
      ..write('File Not Found')
      ..close();
  }
}
