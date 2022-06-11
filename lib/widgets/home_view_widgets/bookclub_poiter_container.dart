import 'package:flutter/material.dart';

import '../../ui/views/home_view/event_details_view/event_details_view.dart';

class BookClubPointer extends StatelessWidget {
  // String tagText;
  // String location;
  // String date;
  // String time;
  // String joined;
  // String spotsLeft;
  // String profile;

  // BookClubPointer({
  //   required this.tagText,
  //   required this.location,
  //   required this.date,
  //   required this.time,
  //   required this.spotsLeft,
  //   required this.joined,
  //   required this.profile,
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

    return StackedWidget(
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
        color: Colors.black,
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
