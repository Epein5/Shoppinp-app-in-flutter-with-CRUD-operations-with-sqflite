import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/cart_provider.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routename.splashscreen,
          onGenerateRoute: Routes.generateRoutes,
        );
      }),
    );
  }
}
