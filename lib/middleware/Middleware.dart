part of fastweb;

abstract class Middleware {
  Middleware _nextMiddleware;
  void _runMiddlewareChain(Request request, Response response) {
    run(request, response, () { if(_nextMiddleware != null) _nextMiddleware._runMiddlewareChain(request, response); });
  }

  void run(Request request, Response response, next());
}