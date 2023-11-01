import 'package:flutter/material.dart';

CityNotifier cityNotifier = CityNotifier();

class CityNotifier extends ValueNotifier {
  CityNotifier({String? value}) : super(value ?? "");

  void init() {
    cityNotifier = CityNotifier();
  }

  void update(String? city) {
    value = city;
  }
}
