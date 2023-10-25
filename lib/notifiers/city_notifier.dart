import 'package:flutter/material.dart';

final cityNotifier = CityNotifier();

class CityNotifier extends ValueNotifier {
  CityNotifier({String? value}) : super(value ?? "");

  void update(String? city) {
    value = city;
  }
}
