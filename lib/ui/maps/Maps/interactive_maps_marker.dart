library interactive_maps_marker; // interactive_marker_list

import 'dart:async';
import 'dart:typed_data';

import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import './utils.dart';

class MarkerItem {
  int id;
  double latitude;
  double longitude;
  String imgs;
  // String image;

  MarkerItem(
      {required this.id,
      required this.latitude,
      required this.longitude,
      required this.imgs});
}

class InteractiveMapsMarker extends StatefulWidget {
  final LatLng center;
  final double itemHeight;
  final double zoom;

  @required
  List<MarkerItem> items;
  List<MarkerItem> imgs;
  @required
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry itemPadding;
  final Alignment contentAlignment;

  InteractiveMapsMarker({
    required this.items,
    required this.itemBuilder,
    required this.imgs,
    this.center = const LatLng(0.0, 0.0),
    this.itemHeight = 116,
    this.zoom = 12.0,
    this.itemPadding = const EdgeInsets.only(bottom: 20.0),
    this.contentAlignment = Alignment.bottomCenter,
  });

  late Uint8List markerIcon;
  late Uint8List markerIconSelected;

  @override
  _InteractiveMapsMarkerState createState() => _InteractiveMapsMarkerState();
}

class _InteractiveMapsMarkerState extends State<InteractiveMapsMarker> {
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  PageController pageController = PageController(viewportFraction: 0.9);

  Set<Marker> _markers = Set<Marker>();
  List<Marker> customMarkers = [];

  int currentIndex = 0;
  ValueNotifier selectedMarker = ValueNotifier<int>(0);

  @override
  void initState() {
    rebuildMarkers(currentIndex);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    rebuildMarkers(currentIndex);
    super.didChangeDependencies();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: null,
      builder: (context, snapshot) {
        return Stack(
          children: <Widget>[
            _buildMap(),
            Align(
              alignment: widget.contentAlignment,
              child: Padding(
                padding: widget.itemPadding,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: PageView.builder(
                      itemCount: widget.items.length,
                      controller: pageController,
                      onPageChanged: _pageChanged,
                      itemBuilder: widget.itemBuilder),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildMap() {
    return Positioned.fill(
      child: ValueListenableBuilder(
        valueListenable: selectedMarker,
        builder: (context, value, child) {
          return value == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  zoomControlsEnabled: false,
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: widget.center,
                    zoom: widget.zoom,
                  ),
                );
        },
      ),
    );
  }

  // Widget _buildItem(context, i) {
  //   return Transform.scale(
  //     scale: i == currentIndex ? 1 : 0.9,
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(10.0),
  //       child: Container(
  //         height: MediaQuery.of(context).size.height,
  //         decoration: BoxDecoration(
  //           color: Color(0xffffffff),
  //           boxShadow: [
  //             BoxShadow(
  //               offset: Offset(0.5, 0.5),
  //               color: Color(0xff000000).withOpacity(0.12),
  //               blurRadius: 20,
  //             ),
  //           ],
  //         ),
  //         child: widget.itemContent(context, i),
  //       ),
  //     ),
  //   );
  // }
  Future<void> rebuildMarkers(int index) async {
    int current = widget.items[index].id;
    String markerImages = widget.imgs[index].imgs;

    widget.markerIcon = await readNetworkImage(markerImages, 300);

    //  getBytesFromAsset(
    //     'packages/interactive_maps_marker/assets/marker.png', 90);
    widget.markerIconSelected = await readNetworkImage(markerImages, 400);

    widget.items.forEach((item) {
      _markers.add(
        Marker(
          markerId: MarkerId(item.id.toString()),
          position: LatLng(item.latitude, item.longitude),
          onTap: () {
            int tappedIndex =
                widget.items.indexWhere((element) => element.id == item.id);
            pageController.animateToPage(
              tappedIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.bounceInOut,
            );
            _pageChanged(tappedIndex);
          },
          icon: item.id == current
              ? BitmapDescriptor.fromBytes(widget.markerIconSelected)
              : BitmapDescriptor.fromBytes(widget.markerIcon),
        ),
      );
    });

    // setState(() {
    //   markers = _markers;
    // });
    selectedMarker.value = current;
  }

  void _pageChanged(int index) {
    setState(() => currentIndex = index);
    Marker marker = _markers.elementAt(index);
    rebuildMarkers(index);

    mapController
        .animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: marker.position, zoom: 15),
      ),
    )
        .then((val) {
      setState(() {});
    });
  }
}
