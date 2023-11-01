import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/screens/home.dart';
import 'package:weather/sections/no_data_found.dart';
import 'package:weather/sections/weather_card.dart';
import 'package:weather/streams/city_stream_controller.dart';
import 'package:weather/screens/astronomy.dart';
import 'package:weather/streams/navigator_stream_controller.dart';
import 'package:http/http.dart' as http;

class DisplayWeather extends StatefulWidget {
  const DisplayWeather({super.key, required this.city});
  final String? city;

  @override
  State<DisplayWeather> createState() => _DisplayWeatherState();
}

class _DisplayWeatherState extends State<DisplayWeather> {
  late Location location;
  late CurrentWeather currWeather;
  // late Stream? astronomyStream;

  fetchData() async* {
    Stream getStream = cityStreamController.stream.first.asStream();

    Map<String, dynamic> res = await getStream.first;
    location = Location.fromJson(res['location']);
    currWeather = CurrentWeather.fromJson(res['current']);
    yield res;
  }

  @override
  void dispose() {
    super.dispose();
    cityStreamController.close();
  }

  Future fetchAstronomyData(String city) async {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    final String formattedDate = DateFormat('yyyy-MM-dd').format(yesterday);
    final String endpoint =
        "http://api.weatherapi.com/v1/astronomy.json?key=aab02b8362e14d6e8bc61758232210&q=$city&dt=$formattedDate";
    final data = await http.get(Uri.parse(endpoint));
    final Map<String, dynamic> res = jsonDecode(data.body);
    return res;
  }

  void submit() {
    navigationController.add(AstronomyDetailsScreen(
      astronomyStream: Stream.fromFuture(fetchAstronomyData(widget.city ?? "")),
    ));
  }

  Widget constructTableUsingStreamBuilder() {
    return StreamBuilder(
      stream: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 2, 62, 111),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return InkWell(
              onTap: () => submit(),
              child: WeatherCard(
                location: location,
                currWeather: currWeather,
              ),
            );
          }
          if (snapshot.hasError) {
            return const NoDataFound();
          }
        }
        return const Text("Couldn't load data", style: TextStyle(fontSize: 18));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => navigationController.add(const HomeScreen()),
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: const Text(
          "Weather Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 2, 62, 111),
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 225, 224, 221),
        ),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            constructTableUsingStreamBuilder(),
          ],
        ),
      ),
    );
  }
}
