import 'dart:async';

import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:ttranport_01/theme.dart';
import 'package:ttranport_01/utilis/bustops.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStops extends StatelessWidget {
  // Completer<GoogleMapController> _controller = Completer();
  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(32.63826, 74.15926),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  get polygonPoints => null;
  List<LatLng> polycrodinates = [];
  LocationData? currentLocation;
  void getcurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
  }
  Future<LocationData?> _currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
 
    Location location = new Location();
 
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
 
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller = Completer();

    final CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(32.63826, 74.15926),
      zoom: 14.4746,
    );
    final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(32.63826, 74.15926),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    List<LatLng> latlng = [
      LatLng(32.9271355320079, 73.7267997547384),
      LatLng(32.5987424217271, 74.0582084316235),
      LatLng(32.5518291442681, 74.0795127258921),
      LatLng(32.5557117559204, 74.088259914689),
      LatLng(32.5564129357729, 74.0967149856799),
      LatLng(32.5695375338872, 74.0998274453349),
      LatLng(32.5888948334382, 74.4963698199793),
      LatLng(32.6726338924775, 74.4643342528791),
      LatLng(32.6830054821807, 74.430570573976),
      LatLng(32.6726566262506, 74.430570573975),
      LatLng(32.9053387788661, 73.7504124259018),
      LatLng(32.8185417323114, 73.8808017759278),
      LatLng(32.7027240464578, 73.9580063641619),
      LatLng(32.5011969429634, 74.0895926203833),
      LatLng(32.4811515789866, 74.010831849562),
      LatLng(32.442446679164, 74.1187606820707),
      LatLng(32.4464900062502, 74.1313254525151),
      LatLng(32.4719888763018, 74.2598211924698),
      LatLng(32.1764540429847, 74.1832745907727),
      LatLng(32.63826, 74.15926)
    ];

    Set<Marker> markers = getMarkersSet();
    final Set<Polyline> _polyline = {};
    Map<PolygonId, Polygon> mapsPolygons = <PolygonId, Polygon>{};
    void tapMap(LatLng pos) {
      final PolygonId polygonId = PolygonId("Polgon_1");
      final Polygon polygon = Polygon(
        polygonId: polygonId,
        strokeColor: Colors.red,
        strokeWidth: 5,
        fillColor: Colors.red.withOpacity(0.3),
        points: polygonPoints,
      );
      mapsPolygons[polygonId] = polygon;

      //setState((){});
    }

    @override
    void initState() {
      getcurrentLocation();
      for (int i = 0; i < latlng.length; i++) {
        markers.add(Marker(
            markerId: MarkerId(i.toString()),
            position: latlng[i],
            icon: BitmapDescriptor.defaultMarker));
        setState(() {});
      }
      ;
    }

    _polyline.add(
      Polyline(
        polylineId: PolylineId('1'),
        points: latlng,
        color: kPrimaryColor,
      ),
    );
    return Scaffold(
      body: GoogleMap(
        polygons: Set<Polygon>.of(mapsPolygons.values),
        polylines: _polyline,
        onTap: tapMap,
        initialCameraPosition: CameraPosition(
          target: markers.first.position,
          zoom: 15,
        ),
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the UOG!'),
        icon: Icon(Icons.gps_fixed),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void setState(Null Function() param0) {}
}
