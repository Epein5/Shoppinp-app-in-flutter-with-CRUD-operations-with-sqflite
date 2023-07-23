import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/cartscreem.dart';
import 'package:flutter_application_1/pages/productscreen.dart';
import 'package:flutter_application_1/pages/splashscreen.dart';

class Routename {
  static const String splashscreen = "SplashScreen";

  static const String productlistscreen = "ProductListScreen";
  static const String cartscreen = "CartScreen";
}

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routename.splashscreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case Routename.productlistscreen:
        return MaterialPageRoute(builder: (context) => ProductListScreen());
      case Routename.cartscreen:
        return MaterialPageRoute(builder: (context) => CartScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No Rutes Choosen"),
            ),
          );
        });
    }
  }
}
