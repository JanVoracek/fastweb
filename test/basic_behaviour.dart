part of fastweb_tests;

basic_behaviour_tests() {
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