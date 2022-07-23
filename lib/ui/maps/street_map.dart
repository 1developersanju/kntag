import 'package:flutter/material.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import 'package:kntag/widgets/colorAndSize.dart';

class StreetMap extends StatefulWidget {

  @override
  State<StreetMap> createState() => _StreetMapState();
}

class _StreetMapState extends State<StreetMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Location'),
      ),
      body: FlutterOpenStreetMap(
          primaryColor: buttonBlue,
          showZoomButtons: true,
          center: LatLong(5, 10),
          onPicked: (pickedData) {
            print(pickedData.latLong.latitude);
            print(pickedData.latLong.longitude);
            print(pickedData.address);
            Navigator.of(context).pop(pickedData.address);
          }),
    );
  }
}
