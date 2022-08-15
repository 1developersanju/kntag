library interactive_maps_marker; // interactive_marker_list

import 'dart:async';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kntag/app/db.dart';
import 'package:kntag/app/services/dialog.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/ui/views/profile_view/profile_view.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final void Function(int) changePage;

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
    required this.changePage,
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
  String currentAddress = "";

  final geolocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  Position? _currentPosition;
  late GoogleMapController mapController;
  PageController pageController = PageController(viewportFraction: 0.9);

  Set<Marker> _markers = Set<Marker>();
  List<Marker> customMarkers = [];

  int currentIndex = 0;
  int currentIndexs = 0;
  ValueNotifier selectedMarker = ValueNotifier<int>(0);
  @override
  void initState() {
    rebuildMarkers(currentIndex);
    getCurrentLocation();
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

  void getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      getAddressFromLatLng();
    }).catchError((e) {
      print("errrror:$e");
    });
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
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,

        // automaticallyImplyLeading: false,
        backgroundColor: transparent,
        //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        flexibleSpace: Container(
          height: 100,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              right: 8,
              left: 8,
              bottom: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print("tappedd");
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: widget.center, zoom: 17)
                        //17 is new zoom level
                        ));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: buttonBlue,
                      ),
                      Text(
                        currentAddress.toString(),
                        style: TextStyle(color: buttonBlue, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                AutoSizeText(
                  "Kntag",
                  style: TextStyle(
                      color: titleColor,
                      fontSize: 25.sp,
                      fontFamily: "Singolare",
                      fontStyle: FontStyle.normal),
                  maxLines: 1,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        print(user?.displayName);
                        // print("user Data${getData()}");

                        // print("object");

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileView(
                                    changePage: (int index) {
                                      // setState(() {
                                      //   currentIndexs = index;
                                      // });
                                      print("_changeTa2b $index");
                                      widget.changePage(index);
                                    },
                                  )),
                        );
                      },
                      child: Hero(
                        tag: "profile",
                        child: FirebaseAuth.instance.currentUser != null
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage("${user?.photoURL}"))
                            : GestureDetector(
                                onTap: () => DialogBox.loginDialog(context),
                                child: CircleAvatar(child: Icon(Icons.person))),
                      )),
                ),
              ],
            ),
          ),
        ),
        actions: [],
      ),
      body: StreamBuilder<int>(
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
                          itemCount: widget.items.length == 0
                              ? 1
                              : widget.items.length,
                          controller: pageController,
                          onPageChanged: _pageChanged,
                          itemBuilder: widget.itemBuilder)),
                ),
              )
            ],
          );
        },
      ),
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
