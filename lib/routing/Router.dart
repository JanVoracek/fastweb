part of fastweb;

class Router extends Middleware {
  List<Route> _routes = new List();

  void run(Request request, Response response, next()) {
    Route route = _routes.firstWhere((Route r) => r.match(request), orElse: () => new ErrorRoute());
    route.run(request, response);
    next();
  }

  Route createRoute(String method, String url) {
    var route =  new UrlRoute(method, url);
    _routes.add(route);
    return route;
  }
}