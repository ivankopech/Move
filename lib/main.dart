import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/location_input.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const LocationInputScreen(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (ctx) {
            switch (settings.name) {
              case LocationInputScreen.routeName:
                return const LocationInputScreen();
              default:
                return const LocationInputScreen();
            }
          },
        );
      },
    );
  }
}
