import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/notifiers/city_notifier.dart';
import 'package:weather/notifiers/city_stream_controller.dart';
import 'package:http/http.dart' as http;

class DisplayWeather extends StatefulWidget {
  const DisplayWeather({super.key});

  @override
  State<DisplayWeather> createState() => _DisplayWeatherState();
}

class _DisplayWeatherState extends State<DisplayWeather> {
  late Location location;
  late CurrentWeather currWeather;
  late WeatherCondition weatherCondition;

  Future fetchData(String city) async {
    final String endpoint =
        "https://api.weatherapi.com/v1/current.json?key=aab02b8362e14d6e8bc61758232210&q=$city&aqi=no";
    final data = await http.get(Uri.parse(endpoint));
    final Map<String, dynamic> res = jsonDecode(data.body);
    return res;
  }

  Stream<Map<String, dynamic>> getStream() async* {
    final String cityName = await cityStream.stream.first;
    final Map<String, dynamic> res = await fetchData(cityName);
    location = Location.fromJson(res['location']);
    currWeather = CurrentWeather.fromJson(res['current']);
    yield res;
  }

  @override
  void dispose() {
    super.dispose();
    cityStream.close();
    cityStream = StreamController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            StreamBuilder(
              stream: getStream(),
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
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 50,
                        ),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                "Property",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Value",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          rows: [
                            DataRow(cells: [
                              const DataCell(Text("City Name")),
                              DataCell(Text(location.name)),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text("Temperature (Celsius)")),
                              DataCell(Text("${currWeather.tempC}")),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text("Wind (kph)")),
                              DataCell(Text("${currWeather.windKph}")),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text("Pressure")),
                              DataCell(Text("${currWeather.pressureIn}")),
                            ]),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: const Column(
                          children: [
                            Text(
                              "Oops... Couldn't fetch data",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 153, 6, 6),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Icon(
                              Icons.do_disturb_alt_outlined,
                              size: 34,
                              color: Color.fromARGB(255, 153, 6, 6),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }
                return const Text("Couldn't load data",
                    style: TextStyle(fontSize: 18));
              },
            )
          ],
        ),
      ),
    );
  }
}
