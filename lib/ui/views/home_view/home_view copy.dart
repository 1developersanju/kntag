// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kntag/app/services/dialog.dart';
import 'package:kntag/app/services/shared_pref.dart';
// import 'package:interactive_maps_marker/interactive_maps_marker.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
// import 'package:kntag/drawer.dart';
import 'package:kntag/ui/maps/Maps/interactive_maps_marker.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/widgets/home_view_widgets/Bookclub_container.dart';
import 'package:sizer/sizer.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:widget_marker_google_map/widget_marker_google_map.dart';

class HomePage extends StatefulWidget {
  final void Function(int) changePage;

  HomePage({
    required this.changePage,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GroupTagList> containerDetails = [];
  int currentIndex = 0;
  String currentAddress = "";
  final geolocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  late GoogleMapController mapController;

  final dbRef = FirebaseDatabase.instance.ref();
  var usersnap;
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getCurrentLocation();
  //   containerDetails = tagTileDatas();
  //   _changeTab;
  //   var i = {"id": 9};
  // }

  void _changeTab(int index) {
    // setState(() {
    //   currentIndex = index;
    // });
    widget.changePage(index);
    print("_changeTabpage1 $index");
  }

  Position? _currentPosition;

  addmarkers(userS) async {
    for (var i = 0; i < userS.child("tags").children.toList().length; i++) {
      // markers.add(MarkerItem(
      //   id: i,
      //   latitude: double.parse(userS
      //       .child("tags")
      //       .children
      //       .toList()[i]
      //       .child('map/latitude')
      //       .value),
      //   longitude: double.parse(userS
      //       .child("tags")
      //       .children
      //       .toList()[i]
      //       .child('map/londitude')
      //       .value),
      //   imgs:
      //       "https://github.com/1developersanju/img/blob/main/marker.png?raw=true",
      // ));
    }
  }

  getData() async {
    getString();
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
          _currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0);

      Placemark place = p[0];

      setState(() {
        currentAddress = "${place.locality}";
      });
    } catch (e) {
      print("exceeeptionnn$e");
    }
  }

  List tagMembers = [];
  List tagMembersProfile = [];

  List<MarkerItem> markers = [];
  Future<Map<String, dynamic>> future() async {
    final tags = await FirebaseDatabase.instance.ref('tags').get();
    final data = Map<String, dynamic>.from(tags.value as Map);
    final hostID = data['8ux4wwBY03NN2xpM01LXK58rkgF2Tag3947']['hostId'];
    final users = await FirebaseDatabase.instance.ref('users/$hostID').get();
    return <String, dynamic>{
      'tags': Map<String, dynamic>.from(tags.value as Map),
      'users': Map<String, dynamic>.from(users.value as Map)
    };
  }

  late PageController _pageController;
  late GoogleMapController _controller;
  var previousPage;
  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  List<WidgetMarker> allMarkers = [];
  @override
  void initState() {
    super.initState();

    coffeeShops.forEach((element) {
      allMarkers.add(
        WidgetMarker(
          position: element.locationCoords,
          markerId: element.shopName,
          draggable: true,
          // infoWindow: InfoWindow(
          //   title: element.shopName,
          // ),
          widget: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30, color: Colors.red, //width: 80,
                padding: const EdgeInsets.all(2),
                child: Text(element.shopName),
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
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(() {
        _onScroll();
      });
    // ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page?.toInt() != previousPage) {
      previousPage = _pageController.page!.toInt();
      moveCamera();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            child: widget,
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
          ),
        );
      },
      child: InkWell(
        // onFocusChange: (autofcus) {
        //  moveCamera();}

        onTap: () {
          //  _onScroll();
          // moveCamera();
        },
        child: Stack(children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              height: 125,
              width: 275,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    )
                  ]),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        image: DecorationImage(
                            image: NetworkImage(coffeeShops[index].thumbnail),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coffeeShops[index].shopName,
                          style: TextStyle(
                              fontSize: 12.5, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          coffeeShops[index].address,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          width: 150,
                          child: Text(
                            coffeeShops[index].description,
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: coffeeShops[_pageController.page!.toInt()].locationCoords,
      zoom: 14.0,
      bearing: 45.0,
      tilt: 45.0,
    )));
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final user = FirebaseAuth.instance.currentUser;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // drawer: Drawer(child: Drawerpage()),
      extendBodyBehindAppBar: true,

      body: Stack(
        children: <Widget>[
          // ignore: sized_box_for_whitespace
          Container(
            height: height,
            width: width,
            child: WidgetMarkerGoogleMap(
              // onTap: ,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(11.057786, 76.991440), zoom: 12),
              widgetMarkers: allMarkers,
              onMapCreated: mapCreated,
              mapType: MapType.normal,
            ),
          ),
          Positioned(
            bottom: 5,
            child: Container(
                height: 200,
                width: width,
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: coffeeShops.length,
                    itemBuilder: (context, index) {
                      return _coffeeShopList(index);
                    })),
          )
        ],
      ),
    );
  }
}

class Coffee {
  String shopName;
  String address;
  String description;
  String thumbnail;
  LatLng locationCoords;
  Coffee(
      {required this.shopName,
      required this.address,
      required this.thumbnail,
      required this.description,
      required this.locationCoords});
}

final List<Coffee> coffeeShops = [
  Coffee(
    shopName: 'Ragam Bakes',
    address: '278 sathy road',
    thumbnail: 'https://ragamcakes.com/UnderConstruction/images/logo.png',
    description: 'specials in cake items',
    locationCoords: const LatLng(
      11.065242,
      77.000488,
    ),
  ),
  Coffee(
    shopName: 'KR Bakes',
    address: '1263-B, Mettupalayam Rd',
    thumbnail:
        'https://cdn1.vectorstock.com/i/1000x1000/58/10/bakery-shop-front-veiw-flat-icon-vector-17255810.jpg',
    description: 'specials in tea,coffee items',
    // ignore: prefer_const_constructors
    locationCoords: LatLng(11.022223, 76.947448),
  ),
  Coffee(
    shopName: 'parsely Bakes',
    address: '126-e, Avinashi Rd',
    thumbnail:
        'https://image.shutterstock.com/image-photo/kuala-lumpur-malaysia-august-25-260nw-1165039456.jpg',
    description: 'specials in spicy and sweet items',
    // ignore: prefer_const_constructors
    locationCoords: LatLng(11.036713, 77.041925),
  )
];
