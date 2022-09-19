
// import 'package:capture_tree/src/services/firebaseService.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:geocode/geocode.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LeaderboardsViewModel extends ChangeNotifier {
//   List<Coordinates> myDrives1 = [];
//   List<DriveModel> myDrives = [];
//   bool isDataFetch = false;
//   Set<Marker> markers = <Marker>{};
//   late BitmapDescriptor icon;
//   Future setSourceAndDestinationIcons() async {
//     icon = await BitmapDescriptor.fromAssetImage(
//         const ImageConfiguration(devicePixelRatio: 0.5, size: Size(5, 5)),
//         'assets/tree.png');
//     isDataFetch = false;
//   }

//   addMarkers() {
//     int index = 0;
//     for (var i in myDrives1) {
//       markers.add(Marker(
//           markerId: MarkerId(i.latitude.toString() + i.longitude.toString()),
//           position: LatLng(i.latitude!, i.longitude!),
//           icon: icon));
//       index++;
//     }
//     // notifyListeners();
//   }

//   getDrivesData() async {
//     List<DriveModel> drives = await FirebaseService.getDrivesFor();
//     myDrives = drives.reversed.toList();
//     notifyListeners();
//   }

//   getLocationOfTrees() async {
//     await setSourceAndDestinationIcons();
//     List<Coordinates> drives = await FirebaseService.getLocationOfTrees();
//     myDrives1 = drives;
//     // print("**");
//     // print(myDrives1);
//     await addMarkers();
//     isDataFetch =true;
//     notifyListeners();
//   }
// }