library interactive_maps_marker; // interactive_marker_list

import 'dart:async';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kntag/app/db.dart';
import 'package:kntag/app/services/dialog.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/ui/views/profile_view/profile_test.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:widget_marker_google_map/widget_marker_google_map.dart';
import '../../../widgets/Profile_view_widgets/book_club_container.dart';
import './utils.dart';

class MarkerItem {
  int id;
  double latitude;
  double longitude;
  String imgs;
  String tagname;
  List markerimg;

  MarkerItem({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.imgs,
    required this.tagname,
    required this.markerimg,
  });
}

class InteractiveMapsMarker extends StatefulWidget {
  final void Function(int) changePage;

  final LatLng center;
  final LatLng initialLocation;
  List markerimgs;
  final double itemHeight;
  final double zoom;
  @required
  List<MarkerItem> items;
  int itemcount;
  List<MarkerItem> imgs;
  @required
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry itemPadding;
  final Alignment contentAlignment;
  String userid;
  InteractiveMapsMarker({
    required this.userid,
    required this.markerimgs,
    required this.initialLocation,
    required this.itemcount,
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

  List<WidgetMarker> allMarkers = [];
  List<Marker> customMarkers = [];

  int currentIndex = 0;
  int currentIndexs = 0;
  ValueNotifier selectedMarker = ValueNotifier<int>(0);

  @override
  void initState() {
    getCurrentLocation();
    widget.items.forEach((item) {
      allMarkers.add(
        WidgetMarker(
          position: LatLng(item.latitude, item.longitude),
          markerId: item.id.toString(),
          draggable: true,
          // infoWindow: InfoWindow(
          //   title: element.shopName,
          // ),
          onTap: () {
            int tappedIndex =
                widget.items.indexWhere((element) => element.id == item.id);
            pageController.animateToPage(
              tappedIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
            );
            _pageChanged(tappedIndex);
          },
          widget: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                height: 120,
                width: 120,
                child: Center(
                  // child: Image.network("${item.imgs}"),
                  child: Column(
                    children: [
                      Card(
                        color: loginTextColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            item.tagname,
                            style: TextStyle(
                                fontFamily: "Singolare",
                                fontSize: 18,
                                color: Colors.white),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Image.asset(
                                "assets/markerbg.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: buildStackedImages(item.imgs)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      print("image markers ${widget.markerimgs}");
    });
    setState(() {});
    // getCurrentLocation();

    super.initState();
  }

  late PageController _pageController;

  // void _onScroll() {
  //   if (_pageController.page?.toInt() != previousPage) {
  //     previousPage = _pageController.page!.toInt();
  //     moveCamera();
  //   }
  // }

  @override
  void didChangeDependencies() {
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
                  onLongPress: () {
                    print("item count ${widget.items.length}");
                    print("item count ${widget.items}");
                  },
                  onTap: () {
                    print("tappedd");
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: widget.center, zoom: 12)
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
                      currentAddress != ""
                          ? Text(
                              currentAddress.toString(),
                              style:
                                  TextStyle(color: buttonBlue, fontSize: 13.sp),
                            )
                          : Text("empty.."),
                    ],
                  ),
                ),
                Spacer(),

                // Spacer(),
              ],
            ),
          ),
        ),
        title: AutoSizeText(
          "Kntag",
          style: TextStyle(
              color: titleColor,
              fontSize: 25.sp,
              fontFamily: "Singolare",
              fontStyle: FontStyle.normal),
          maxLines: 1,
        ),
        centerTitle: true,
        actions: [
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
                              userId: user?.uid ?? "Guest",
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
                          backgroundImage: NetworkImage("${user?.photoURL}"))
                      : GestureDetector(
                          onTap: () => DialogBox.loginDialog(context),
                          child: CircleAvatar(child: Icon(Icons.person))),
                )),
          ),
        ],
      ),
      body: StreamBuilder<int>(
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
                          itemCount: widget.itemcount,
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
              : WidgetMarkerGoogleMap(
                  compassEnabled: false,
                  indoorViewEnabled: false,
                  zoomControlsEnabled: false,
                  buildingsEnabled: true,
                  zoomGesturesEnabled: true,
                  widgetMarkers: allMarkers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: widget.itemcount == 0
                        ? widget.center
                        : widget.initialLocation,
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
    print("located rebuildMarkers");
    int current = widget.items[index].id;
    String markerImages = widget.imgs[index].imgs;

    widget.markerIcon = await readNetworkImage(markerImages, 300);

    //  getBytesFromAsset(
    //     'packages/interactive_maps_marker/assets/marker.png', 90);
    widget.markerIconSelected = await readNetworkImage(markerImages, 400);
    print("got rebuildMarkers images");

    print("entered rebuildMarkers foreach loop");
    widget.items.forEach((item) {
      allMarkers.add(
        WidgetMarker(
          position: LatLng(item.latitude, item.longitude),
          markerId: item.id.toString(),
          draggable: true,
          // infoWindow: InfoWindow(
          //   title: element.shopName,
          // ),
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
          widget: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Card(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: 50,
                  width: 120,
                  child: Center(
                    child: AutoSizeText(
                      "???${item.tagname}",
                      style: TextStyle(
                          fontFamily: "Singolare",
                          fontSize: 15,
                          color: Colors.white),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Marker(
        //     markerId: MarkerId(element.shopName),
        //     draggable: true,
        //     infoWindow:
        //         InfoWindow(title: element.shopName, snippet: element.address),
        //     position: element.locationCoords),
      );
    });

    print("end rebuildMarkers");

    // setState(() {
    //   markers = _markers;
    // });
    setState(() {
      selectedMarker.value = current;
    });
  }

  void _pageChanged(int index) {
    setState(() => currentIndex = index);
    WidgetMarker marker = allMarkers.elementAt(index);
    // rebuildMarkers(index);

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

  Widget buildStackedImages(images) {
    var membersJoined = 0;
    final double size = 9.w;
    final urlImages = images.isEmpty ? [user?.photoURL] : [images];

    final items = urlImages.map((urlImage) => buildImage(urlImage)).toList();

    return StackedWidget(
      items: items,
      size: size,
    );
  }

  Widget buildImage(String urlImage) {
    final double borderSize = 0.8;

    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(borderSize),
        color: Colors.white,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: urlImage,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
