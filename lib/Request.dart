part of fastweb;
class Request {

  HttpRequest _rawRequest;

  Request(HttpRequest httpRequest) {
    _rawRequest = httpRequest;
    _method = _rawRequest.method;
    _uri = _rawRequest.uri;
  }

  String _method;

  String get method => _method;

  Uri _uri;

  Uri get uri => _uri;

  Future<List<List<int>>> getBody() {
    return _rawRequest.toList();
  }
}
