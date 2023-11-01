import 'package:flutter/material.dart';
import 'package:weather/screens/home.dart';
import 'package:weather/streams/navigator_stream_controller.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: navigationController.stream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const HomeScreen();
        }
        return snapshot.data;
      },
    );
  }
}
