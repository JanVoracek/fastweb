library fastweb;

import 'dart:async';
import 'dart:io';

part 'Request.dart';
part 'Response.dart';
part 'middleware/Middleware.dart';
part 'routing/Route.dart';
part 'routing/Router.dart';

class Fastweb {
  Router _router = new Router();
  List<Middleware> _middlewares = new List();
  bool _autoUseRouter;

  Router get router => _router;

  Route post(String url) {
    return _createRoute('POST', url);
  }

  Route get(String url) {
    return _createRoute('GET', url);
  }

  void use(Middleware middleware) {
    if(_middlewares.length > 0){
      _middlewares.last._nextMiddleware = middleware;
    }
    _middlewares.add(middleware);
  }

  Route _createRoute(String method, String url) {
    _autoUseRouter = true;
    return _router.createRoute(method, url);
  }

  run(Request request, Response response) {
    if(_autoUseRouter && !_middlewares.contains(_router)) use(_router);
    if(_middlewares.length > 0) _middlewares.first._runMiddlewareChain(request, response);
  }

  call(HttpServer server) {
    server.listen((HttpRequest request) {
      run(new Request(request), new Response(request.response));
    });
  }
}
