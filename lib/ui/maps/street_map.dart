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
        body: FlutterOpenStreetMap(
            primaryColor: buttonBlue,
            showZoomButtons: true,
            center: LatLong(11.0069503698218, 76.97023429695152),
            onPicked: (pickedData) {
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print(pickedData.address);
              Navigator.of(context).pop(pickedData.address);
            }),
      ),
    );
  }
}
