import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:ttranport_01/Map/neww01.dart';
import 'package:ttranport_01/theme.dart';
import 'package:ttranport_01/transport.dart';
import 'package:ttranport_01/utilis/stops.dart';
import 'package:ttranport_01/widgets/Bottom.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(backgroundColor: Colors.blue.shade300),
      home: Scaffold(
        appBar: AppBar(
          title: Text("UOG Tranport"),
          centerTitle: true,
          backgroundColor: Colors.blue.shade300,
        ),
        body: Scaffold(
          bottomNavigationBar: BottomNavBar(
            onCountChange: (Widget C) {
              setState(() {});
            },
            currentScreen: Transportpage(),
          ),
          body: new Column(children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(
                  top: 100, bottom: 100, left: 250, right: 250),
            ),
            AnimatedButton(
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BusStops()));
              },
              height: 70,
              width: 200,
              text: 'Open Map',
              isReverse: true,
              selectedTextColor: kPrimaryColor,
              transitionType: TransitionType.LEFT_TO_RIGHT,
            
              backgroundColor: kPrimaryColor,
              borderColor: Colors.white,
              borderRadius: 50,
              borderWidth: 2,
            ),
            
          ]),
        ),
      ),
    );
  }
}
