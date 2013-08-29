part of fastweb;

abstract class Route {
  bool match(Request request);

  void run(Request request, Response response);

  Route listen(void onRequest(Request request, Response response));
}

class UrlRoute implements Route {
  String _method;

  String _url;

  Function _handler;

  UrlRoute(this._method, this._url);

  Route listen(void onRequest(Request request, Response response)) {
    _handler = onRequest;
  }

  bool match(Request request) {
    return request.method == _method && request.uri.path == _url;
  }

  run(Request request, Response response) {
    if(_handler != null)
      _handler(request, response);
  }
}

class ErrorRoute implements Route {
  listen(void onRequest(Request request, Response response)) {
    throw new Exception("Error route cannot be listened");
  }

  match(Request request) => true;

  run(Request request, Response response) {
    response.statusCode = 404;
    response.close();
  }
}