library fastweb;

import 'dart:async';
import 'dart:io';

class Fastweb {
  call(HttpServer server) {
    server.listen((HttpRequest request) {
      request.response.write('Hello world');
      request.response.close();
    });
  }
}
