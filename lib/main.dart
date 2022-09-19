import 'package:flutter/material.dart';
import 'package:ttranport_01/utilis/stops.dart';

import 'package:ttranport_01/widgets/splash_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home:BusStops());
  }
}
