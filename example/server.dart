import 'dart:io';
import 'package:fastweb/fastweb.dart';

main() {
  var fw = new Fastweb();

  fw.get('/').listen((Request request, Response response){
    response.send('Hello Fastweb');
  });

  HttpServer.bind('127.0.0.1', 8080).then(fw);
}