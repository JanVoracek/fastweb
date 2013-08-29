import 'dart:io';
import 'dart:utf' as Utf;
import 'package:fastweb/fastweb.dart';


class RequestLog extends Middleware {
  run(Request request, Response response, next()) {
    print('${request.method}: ${request.uri.toString()}');
    next();
  }
}

main() {
  var fw = new Fastweb();
  fw.use(new RequestLog());
  fw.use(fw.router);

  fw.get('/').listen((Request request, Response response){
    response.write('Hello fastweb');
    response.close();
  });

  fw.post('/').listen((request, response) {
    response.close();
  });

  HttpServer.bind('127.0.0.1', 8080).then(fw);
}