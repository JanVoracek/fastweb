part of fastweb_tests;

class CallbackMiddleware extends Middleware {
  Function _callback;
  CallbackMiddleware(this._callback);

  void run(Request request, Response response, next()) {
    _callback(next);
  }
}

middleware_tests() {

  var _createMiddlewareThatCallsTheNextOne = (callback) => new CallbackMiddleware((next){ callback(); next(); });
  var _createMiddlewareThatDoesntCallTheNextOne = (callback) => new CallbackMiddleware((next){ callback(); });

  Fastweb app;
  setUp((){
    app = new Fastweb();
  });

  test('middlewares are called in the same order as they were added', (){
    var order = 0;

    var firstMiddleware = _createMiddlewareThatCallsTheNextOne((){
      expect(order, equals(0));
      order += 1;
    });

    var secondMiddleware = _createMiddlewareThatCallsTheNextOne((){
      expect(order, equals(1));
      order += 1;
    });

    var thirdMiddleware = _createMiddlewareThatCallsTheNextOne((){
      expect(order, equals(2));
      order += 1;
    });


    app..use(firstMiddleware)
       ..use(secondMiddleware)
       ..use(thirdMiddleware);

    app.run(null, null);
  });

  test('middleware chain is stopped if middleware does not call next()', (){
    var firstMiddleware = _createMiddlewareThatDoesntCallTheNextOne(expectAsync0((){}));

    var secondMiddleware = _createMiddlewareThatCallsTheNextOne(protectAsync0((){
      expect(true, isFalse, reason: 'The second middleware shoud not be run');
    }));

    app..use(firstMiddleware)
       ..use(secondMiddleware);

    app.run(null, null);
  });
}