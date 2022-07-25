import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:kntag/widgets/home_view_widgets/Bookclub_container.dart';

class GestureDetectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        width: double.infinity,
        height: double.infinity,
        child: MainContent(),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  GlobalKey key = GlobalKey();

  String dragDirection = '';
  String startDXPoint = '50';
  String startDYPoint = '576';
  String dXPoint = '';
  String dYPoint = '';
  String velocity = '';
  var containerSize;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var containerWidth = size.width * 0.5;
    return GestureDetector(
      onTap: () {},
      onHorizontalDragStart: _onHorizontalDragStartHandler,
      onHorizontalDragUpdate: _onDragUpdateHandler,
      onVerticalDragUpdate: (DragUpdateDetails details) {
        print("value $details");

        setState(() {
          this.dragDirection = "UPDATING";
          this.startDXPoint = '${details.globalPosition.dx.floorToDouble()}';
          this.startDYPoint = '${details.globalPosition.dy.floorToDouble()}';
          containerWidth = map(double.parse(startDYPoint), size.height,
              size.height * 0.6, size.width * 0.6, size.width);
        });
        print("containerWidth $containerWidth");
      },
      onHorizontalDragEnd: _onDragEnd,

      onVerticalDragEnd: _onDragEnd,
      dragStartBehavior: DragStartBehavior.start, // default
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          double.parse(startDYPoint) > (0.6) * size.height
              ? Positioned(
                  // left: size.width * 0.1,
                  // right: size .width * 0.1,
                  top: double.parse(this.startDYPoint),
                  child: GestureDetector(
                    onPanUpdate: ((details) {
                      setState(() {
                        containerWidth = size.width;
                      });
                    }),
                    child: Container(
                        height: size.height * 0.25,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: transparent,
                            borderRadius: BorderRadius.circular(6)),
                        child: PageView.builder(
                          controller: PageController(
                            viewportFraction: 0.93,
                            initialPage: 0,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 160.0,
                                color: Colors.red,
                                child: Text("$i"),
                              ),
                            );
                          },
                        )),
                  ),
                )
              : Positioned(
                  top: double.parse(this.startDYPoint),
                  child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Draggable updated',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  void _onHorizontalDragStartHandler(DragStartDetails details) {
    setState(() {
      this.dragDirection = "HORIZONTAL";
      this.startDXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.startDYPoint = '${details.globalPosition.dy.floorToDouble()}';
    });
  }

  double map(x, in_min, in_max, out_min, out_max) {
    //https://arduino.stackexchange.com/questions/32148/explanation-of-the-formula-of-the-map-funtion
    return ((x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min);
  }

  /// Track starting point of a vertical gesture
  void _onVerticalDragStartHandler(DragStartDetails details) {
    setState(() {
      this.dragDirection = "VERTICAL";
      this.startDXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.startDYPoint = '${details.globalPosition.dy.floorToDouble()}';
    });
  }

  void _onDragUpdateHandler(DragUpdateDetails details) {
    print("value $details");

    setState(() {
      this.dragDirection = "UPDATING";
      this.startDXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.startDYPoint = '${details.globalPosition.dy.floorToDouble()}';
    });
    print(containerSize);
  }

  /// Track current point of a gesture
  void _onHorizontalDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      this.dragDirection = "HORIZONTAL UPDATING";
      this.dXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.dYPoint = '${details.globalPosition.dy.floorToDouble()}';
      this.velocity = '';
      containerSize = containerSize + 0.1;
    });
  }

  /// Track current point of a gesture
  void _onVerticalDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      this.dragDirection = "VERTICAL UPDATING";
      this.dXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.dYPoint = '${details.globalPosition.dy.floorToDouble()}';
      this.velocity = '';
    });
  }

  /// What should be done at the end of the gesture ?
  void _onDragEnd(DragEndDetails details) {
    print("startDy : $startDYPoint");

    double result = details.velocity.pixelsPerSecond.dx.abs().floorToDouble();
    setState(() {
      this.velocity = '$result';
    });
  }
}
