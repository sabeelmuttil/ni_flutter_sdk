import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

const String initialRoute = HomeScreen.routeName;

String rootName = initialRoute;
String currentRouteName = initialRoute;

Route<dynamic> generateRoute(RouteSettings settings) {
  final arguments = settings.arguments;
  currentRouteName = settings.name ?? '';

  Map<String, dynamic> arg =
      arguments != null ? arguments as Map<String, dynamic> : {};

  switch (settings.name) {
    case HomeScreen.routeName:
      return materialPageRoute(const HomeScreen());
    default:
      return materialPageRoute(
        Center(child: const Text("No Route")),
      );
  }
}

MaterialPageRoute<dynamic> materialPageRoute(Widget route) =>
    MaterialPageRoute(builder: (_) => route);
