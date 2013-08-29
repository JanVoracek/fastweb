library fastweb;

import 'dart:async';
import 'dart:io';

part 'Request.dart';
part 'Response.dart';
part 'middleware/Middleware.dart';

class Fastweb {
  Router _router = new Router();
  List<Middleware> _middlewares = new List();

  void use(Middleware middleware) {
    if(_middlewares.length > 0){
      _middlewares.last._nextMiddleware = middleware;
    }
    _middlewares.add(middleware);
  }

  run(Request request, Response response) {
    if(_middlewares.length > 0) _middlewares.first._runMiddlewareChain(request, response);
  }

  call(HttpServer server) {
    server.listen((HttpRequest request) {
      run(new Request(request), new Response(request.response));
    });
  }
}
