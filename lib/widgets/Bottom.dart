import 'package:flutter/material.dart';
import 'package:ttranport_01/Map/neww01.dart';
import 'package:ttranport_01/model/trasnportresponce.dart';
import 'package:ttranport_01/theme.dart';
import 'package:ttranport_01/transport.dart';
import 'package:ttranport_01/utilis/stops.dart';

class BottomNavBar extends StatefulWidget {
  
  Widget currentScreen;
  final Function(Widget) onCountChange;
  BottomNavBar(
      {Key? key,
      
      required this.currentScreen,
      required this.onCountChange})
      : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Widget? currentScreen;
  // @override
  // void initState() {
  //   currentScreen = Home(service: widget.service);
  // }

  int currentTab = 0;
  final List<Widget> screens = [ Transportpage(), BusStops()];
  //final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                      
                    ],
                  ),
                
                MaterialButton(
                  
                  // minWidth: 50,
                  onPressed: () {
                    
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Transportpage()));
                  widget.onCountChange(widget.currentScreen);

  },
  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list,
                        color: currentTab == 2 ? kPrimaryColor : kDarkGreyColor,
                      ),
                      Text(
                        'List',
                        style: TextStyle(
                          color:
                              currentTab == 2 ? kPrimaryColor : kDarkGreyColor,
                        ),
                      )
                    ],
                  ),
                   
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  // minWidth: 50,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BusStops()));
                    
                    widget.onCountChange(widget.currentScreen);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map,
                        color: currentTab == 2 ? kPrimaryColor : kDarkGreyColor,
                      ),
                      Text(
                        'Map',
                        style: TextStyle(
                          color:
                              currentTab == 2 ? kPrimaryColor : kDarkGreyColor,
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  // minWidth: 50,
                  onPressed: () {},
                  //  {
                  //   setState(() {
                  //     currentScreen = Profile();
                  //     currentTab = 3;
                  //   });
                  // },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                      
                      
                    ],
                  ),
                
              
            )
          ],
        ),
          ]
      ),
      )
    
    );
  }
}