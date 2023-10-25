import 'package:flutter/material.dart';
import 'package:weather/notifiers/city_notifier.dart';

class DisplaySelectedCity extends StatefulWidget {
  const DisplaySelectedCity({super.key});

  @override
  State<DisplaySelectedCity> createState() => _DisplaySelectedCityState();
}

class _DisplaySelectedCityState extends State<DisplaySelectedCity> {
  @override
  void dispose() {
    super.dispose();
    cityNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const Text(
            "The selected city is:",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ValueListenableBuilder(
            valueListenable: cityNotifier,
            builder: (context, value, child) => Text(
              cityNotifier.value,
              style: const TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 2, 62, 111),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
