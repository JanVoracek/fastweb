part of fastweb;

class Response {
  int statusCode = 200;

  HttpResponse _rawResponse;

  Response(HttpResponse httpResponse) {
    _rawResponse = httpResponse;
  }

  void send(Object obj) {
    write(obj);
    close();
  }

  void write(Object obj) {
    _rawResponse.write(obj);
  }

  void close() {
    _rawResponse.close();
  }
}
