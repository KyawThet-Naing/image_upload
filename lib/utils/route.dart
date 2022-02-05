import 'package:flutter/material.dart';
import '../pages/home.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Home.route:
        return pageRoute(page: const Home(), routeName: Home.route);

      default:

        ///404 route
        return null;
    }
  }

  static pageRoute({required Widget page, required String routeName}) =>
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(name: routeName),
      );
}
