part of fastweb_tests;

class _Request extends Mock implements Request {
  String _method;

  Uri _uri;

  String get method => _method;

  Uri get uri => _uri;

  Future<List<List<int>>> getBody() => new Completer().future;

  _Request(this._method, this._uri);

}

routing_tests() {
  group('routes -', () {
    test('matching route', () {
      var route = new UrlRoute('GET', '/');
      var request = new _Request('GET', Uri.parse('http://example.com/'));
      expect(route.match(request), isTrue);
    });

    test('non-matching route', () {
      var route = new UrlRoute('GET', '/');
      var request = new _Request('GET', Uri.parse('http://example.com/foo'));
      expect(route.match(request), isFalse);
    });

    test('matching route with query parameters', () {
      var route = new UrlRoute('GET', '/');
      var request = new _Request('GET', Uri.parse('http://example.com/?foo=bar'));
      expect(route.match(request), isTrue);
    });

    test('matching route with fragment', () {
      var route = new UrlRoute('GET', '/');
      var request = new _Request('GET', Uri.parse('http://example.com/#foo'));
      expect(route.match(request), isTrue);
    });
  });

  group('router', () {
    test('calls only the first matching route', () {
      var router = new Router();
      var route1 = router.createRoute('GET', '/');
      var route2 = router.createRoute('GET', '/');

      route1.listen(expectAsync2((request, response){}));
      route2.listen(protectAsync2((request, response){
        expect(true, isFalse, reason: 'It should not be called');
      }));

      var request = new _Request('GET', Uri.parse('http://example.com/'));
      router.run(request, null, (){});
    });
  });
}