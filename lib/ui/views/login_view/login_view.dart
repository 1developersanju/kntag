import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kntag/app/services/decide_login.dart';
import 'package:kntag/app/services/google_login.dart';
import 'package:kntag/bottomNavBarNormal.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  String currentAddress = "";
  final geolocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  late GoogleMapController mapController;
  Position? _currentPosition;

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

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore db = FirebaseFirestore.instance;

    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: transparent,
              actions: [
                TextButton(
                    onPressed: () async {
                      print("hey entered");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyNavigationBar()));
                    },
                    child: Text("Skip", style: TextStyle(fontSize: 11.sp)))
              ],
            ),
            backgroundColor: bgColor,
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/exp5.png"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        blackClr.withOpacity(0.56), BlendMode.darken)),
              ),
              child: Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                // color: bgColor,
                padding:
                    EdgeInsets.only(left: 18, right: 18, top: 20, bottom: 15),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Spacer(),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Create\nConnect\nCelebrate",
                              style: TextStyle(
                                  fontSize: 50.sp, color: loginTextColor),
                            ),
                            // Spacer()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),

                      SizedBox(height: currentHeight * 0.04),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: GoogleAuthButton(
                              onPressed: () async {
                                // RealDB().setData();
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                // prefs.setString('latitude', '${}');

                                final provider =
                                    Provider.of<GoogleLoginProvider>(context,
                                        listen: false);
                                provider.googleSignIn();

                                provider.googleLogin;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DecideLogin()));
                              },
                              text: 'Login with Google',
                              style: AuthButtonStyle(
                                buttonColor: whiteClr,
                                height: currentHeight * 0.06,
                                textStyle: TextStyle(fontSize: 14.sp),
                                //   buttonType: AuthButtonType.secondary,
                                iconType: AuthIconType.secondary,
                                margin: const EdgeInsets.only(bottom: 18),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
