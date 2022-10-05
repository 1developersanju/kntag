import 'package:flutter/material.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kntag/app/services/shared_pref.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreetMap extends StatefulWidget {
  @override
  State<StreetMap> createState() => _StreetMapState();
}

class _StreetMapState extends State<StreetMap> {
  Position? _currentPosition;
  String currentAddress = "";

  void getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print("errrror:$e");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    prefs?.reload();
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p[0];

      setState(() {
        currentAddress = "${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = [];

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Pick Location'),
        ),
        body: _currentPosition != null
            ? FlutterOpenStreetMap(
                primaryColor: buttonBlue,
                showZoomButtons: true,
                center: LatLong(
                    _currentPosition!.latitude, _currentPosition!.longitude),
                onPicked: (pickedData) async {
                  List<Placemark> p = await placemarkFromCoordinates(
                      pickedData.latLong.latitude,
                      pickedData.latLong.longitude);

                  Placemark place = p[0];
                  print(pickedData.latLong.latitude);
                  print(pickedData.latLong.longitude);
                  print("${place.subLocality},${place.locality}");
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.reload();
                  prefs.setString(
                      'place', "${place.subLocality},${place.locality}");
                  prefs.setDouble('latitude', pickedData.latLong.latitude);
                  prefs.setDouble('longitude', pickedData.latLong.longitude);
                  final data = {
                    "place": "${place.subLocality},${place.locality}",
                    "latitude": pickedData.latLong.latitude,
                    "longitude": pickedData.latLong.longitude
                  };

                  Navigator.of(context)
                      .pop("${place.subLocality},${place.locality}");
                  setState(() {});
                })
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
