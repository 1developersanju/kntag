import 'package:flutter/material.dart';
import 'package:kntag/colorAndSize.dart';

class BookClubPointer extends StatelessWidget {
  // String tagText;
  // List userProfile;
  // String joined;

  // BookClubPointer({
  //   required this.tagText,
  //   required this.userProfile,
  //   required this.joined,
  // });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3), color: Colors.red),
          padding: EdgeInsets.all(2.5),
          width: 75,
          height: 20,
          child: Text(
            "#BookClub",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        buildStackedImages(),
        SizedBox(
          height: 10,
        ),
        Text(
          "8 People",
          style: TextStyle(color: Colors.black87, fontSize: 12),
        )
      ],
    );
  }

  // Method for calling StackedWidgets class & for passing image url
  Widget buildStackedImages() {
    final double size = 35;
    final urlImages = [
      "https://c4.wallpaperflare.com/wallpaper/583/178/494/4k-8k-natasha-romanoff-captain-america-civil-war-wallpaper-preview.jpg",
      "https://wallpaperaccess.com/full/2388604.jpg",
      "https://images.wallpapersden.com/image/download/marvel-natasha-romanoff_bGVtZWaUmZqaraWkpJRobWllrWdma2U.jpg"
    ];

    final items = urlImages.map((urlImage) => buildImage(urlImage)).toList();

    return StackedWidgets(
      items: items,
      size: size,
    );
  }

  // Method for providing image $ shape circle
  Widget buildImage(String urlImage) {
    final double borderSize = 0.8;

    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(borderSize),
        color: Colors.white,
        child: ClipOval(
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// Class to stack circles
class StackedWidgets extends StatelessWidget {
  final List<Widget> items;
  final TextDirection direction;
  final double size;
  final double xShift;

  const StackedWidgets({
    Key? key,
    required this.items,
    this.direction = TextDirection.ltr,
    this.size = 10,
    this.xShift = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allItems = items
        .asMap()
        .map((index, item) {
          final left = size - xShift;

          final value = Container(
            width: size,
            height: size,
            margin: EdgeInsets.only(left: left * index),
            child: item,
          );

          return MapEntry(index, value);
        })
        .values
        .toList();

    return Container(
      padding: EdgeInsets.all(3),
      height: 48,
      width: 95,
      decoration: BoxDecoration(
          color: profileBlueColor, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Stack(
          children: direction == TextDirection.ltr
              ? allItems.reversed.toList()
              : allItems,
        ),
      ),
    );
  }
}









// Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.red
//           ),
//           padding: EdgeInsets.all(2.5),
//           width: 75,
//           height: 20,
//           child: Text("#BookClub",style: TextStyle(fontWeight: FontWeight.w400),),
//         ),
//         SizedBox(height: 10,),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.green,
//             borderRadius: BorderRadius.circular(15)
//           ),
//           padding: EdgeInsets.only(left: 2,right: 2,top: 5,bottom: 5),
//           width: 100,
//           height: 30,
//           child: Stack(
//             children: [
//               Container(),
//               Positioned(
//                 left: 2,
//                 child: CircleAvatar(backgroundColor: Colors.green)),
//               Positioned(
//                 left: 2,
//                 child: CircleAvatar(backgroundColor: Colors.black,))
//           ]),
//         ),
//         SizedBox(height: 10,),
//         Text("8 People",style: TextStyle(color: Colors.grey,fontSize: 3.5),)
//       ],
//     );
//   }
// }
