import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({
    super.key,
    required this.location,
    required this.currWeather,
  });
  final Location location;
  final CurrentWeather currWeather;

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Center(
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
              color: Colors.grey.shade300,
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
                DataCell(Text(widget.location.name)),
              ]),
              DataRow(cells: [
                const DataCell(Text("Temperature (Celsius)")),
                DataCell(Text("${widget.currWeather.tempC}")),
              ]),
              DataRow(cells: [
                const DataCell(Text("Wind (kph)")),
                DataCell(Text("${widget.currWeather.windKph}")),
              ]),
              DataRow(cells: [
                const DataCell(Text("Pressure")),
                DataCell(Text("${widget.currWeather.pressureIn}")),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
