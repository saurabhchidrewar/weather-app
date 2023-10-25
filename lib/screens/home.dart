import 'package:flutter/material.dart';
import 'package:weather/notifiers/city_notifier.dart';
import 'package:weather/notifiers/city_stream_controller.dart';
import 'package:weather/screens/display_weather.dart';
import 'package:weather/widgets/city_select_dropdown.dart';
import 'package:weather/widgets/display_selected_city.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> cities = ['Pune', 'Mumbai', 'Delhi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              Text(
                "Weather App",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("( Using streams & valueNotifier )"),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 2, 62, 111),
        toolbarHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 225, 224, 221),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4), // Orangish shade
                ),
                padding: const EdgeInsets.all(16),
                child: const CitySelectDropdown(),
              ),
            ),
            const SizedBox(height: 70),
            const DisplaySelectedCity(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (cityNotifier.value != null &&
                    cityNotifier.value!.isNotEmpty) {
                  cityStream.add(cityNotifier.value ?? "");
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DisplayWeather(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 5, 77, 136),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(15),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: const Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
