//this is a file that showing map & current location

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({Key? key}) : super(key: key);

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  late GoogleMapController googleMapController;
  late GoogleMapController mapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getCustomMarker();
  }

  final LatLng _center = const LatLng(11.011058542747458, 76.88561938630546);

  Set<Marker> markers = Set();

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: _center, zoom: 11.5),
      markers: markers,
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {
        googleMapController = controller;
        getCurrentLocation();
      },
    );
  }

  Future getCurrentLocation() async {
    Position position = await _detrminePosition();
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 11.5)));

    markers.clear();

    markers.add(Marker(
        markerId: MarkerId("current location"),
        infoWindow: InfoWindow(
          title: "Current Location",
        ),
        position: LatLng(position.latitude, position.longitude)));

    setState(() {
      getmarkers();
    });
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId("Locate"),
        position:
            LatLng(11.013578866965481, 76.93194749716262), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: '2',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add second marker
        markerId: MarkerId("caa"),
        position:
            LatLng(11.010826853581017, 76.88566230165002), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: '2',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId("aaadsss"),
        position:
            LatLng(11.026893176687897, 76.90546435298211), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: '3',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }

//this is a function that providing current location permission
  Future<Position> _detrminePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location Unable to fetch");
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return Future.error("Location is denied");
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location are denied 100%");
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  // custom marker function
  // getCustomMarker() async {
  //   var icon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(size: Size(10,10)),
  //       "assets/mario_PNG125.png");
  //   setState(() {
  //   });
  // }
}
