import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:move_app/screens/address_input.dart';

import 'screens/map_input.dart';
import './widgets/address_input.dart';

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
      home: const MapInputScreen(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (ctx) {
            switch (settings.name) {
              case MapInputScreen.routeName:
                return const MapInputScreen();
              case AddressInputScreen.routeName:
                return const AddressInputScreen();
              default:
                return const MapInputScreen();
            }
          },
        );
      },
    );
  }
}
