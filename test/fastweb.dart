library fastweb_tests;
import 'package:unittest/unittest.dart';
import 'package:unittest/mock.dart';

import 'package:fastweb/fastweb.dart';

import 'dart:async';

part 'basic_behaviour.dart';
part 'middleware.dart';

main() {
  basic_behaviour_tests();
  middleware_tests();
}