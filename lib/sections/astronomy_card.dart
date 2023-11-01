import 'package:flutter/material.dart';
import 'package:weather/models/astronomy.dart';

class AstronomyCard extends StatefulWidget {
  const AstronomyCard({
    super.key,
    required this.astronomyData,
  });
  final AstronomyData astronomyData;

  @override
  State<AstronomyCard> createState() => _AstronomyCardState();
}

class _AstronomyCardState extends State<AstronomyCard> {
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
                const DataCell(Text("Sunrise")),
                DataCell(Text(widget.astronomyData.sunrise)),
              ]),
              DataRow(cells: [
                const DataCell(Text("Sunset")),
                DataCell(Text(widget.astronomyData.sunset)),
              ]),
              DataRow(cells: [
                const DataCell(Text("Moonrise")),
                DataCell(Text(widget.astronomyData.moonrise)),
              ]),
              DataRow(cells: [
                const DataCell(Text("Moonset")),
                DataCell(Text(widget.astronomyData.moonset)),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
