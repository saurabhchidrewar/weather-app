import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather/models/astronomy.dart';
import 'package:weather/screens/home.dart';
import 'package:weather/sections/astronomy_card.dart';
import 'package:weather/sections/no_data_found.dart';
import 'package:weather/streams/navigator_stream_controller.dart';

class AstronomyDetailsScreen extends StatefulWidget {
  const AstronomyDetailsScreen({super.key, this.astronomyStream});
  final Stream? astronomyStream;

  @override
  State<AstronomyDetailsScreen> createState() => _AstronomyDetailsScreenState();
}

class _AstronomyDetailsScreenState extends State<AstronomyDetailsScreen> {
  AstronomyData? astronomyData;
  StreamController localAstroStream = StreamController();

  setData() async {
    Stream? astroStream = widget.astronomyStream;
    Map<String, dynamic> res = await astroStream?.first;
    astronomyData = AstronomyData.fromJson(res);
    localAstroStream.add(res);
  }

  @override
  void dispose() {
    localAstroStream.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setData();
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
          "History",
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
      body: StreamBuilder(
        stream: localAstroStream.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 2, 62, 111),
              ),
            );
          }
          if (snapshot.data == null) return const NoDataFound();

          return AstronomyCard(
            astronomyData: astronomyData!,
          );
        },
      ),
    );
  }
}
