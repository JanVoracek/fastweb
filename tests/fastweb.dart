library fastweb_tests;
import 'package:unittest/unittest.dart';
import 'package:fastweb/fastweb.dart';

main() {
  Fastweb fw;

  setUp((){
    fw = new Fastweb();
  });

  group('Fastweb', () {
    test('is callable', () {
      expect(fw.call is Function, isTrue);
    });
  });
}