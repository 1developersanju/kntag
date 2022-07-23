import 'package:flutter/material.dart';
import 'package:kntag/widgets/colorAndSize.dart';

class PostSettingView extends StatefulWidget {
  const PostSettingView({Key? key}) : super(key: key);

  @override
  State<PostSettingView> createState() => _PostSettingViewState();
}

class _PostSettingViewState extends State<PostSettingView> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("Post Settings"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [PopupMenuItem(child: Text("change"))],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Expanded(
                flex: 4,
                child: Container(
                    width: currentWidth,
                    height: currentHeight * 0.25,
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: currentWidth,
                          height: currentHeight * 0.30,
                          color: transparent,
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: currentHeight * 0.22,
                          ),
                        ),
                        Positioned(
                          right: 124,
                          bottom: 6,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.check,),
                          ),
                        )
                      ],
                    )),
              ),

              Spacer(),
              //-------------------------
              Text(
                "Show to",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.grey[800]),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Color.fromARGB(255, 2, 107, 194)),
                            backgroundColor: Colors.white,
                            primary: greyText,
                            fixedSize:
                                Size(currentWidth / 3.5, currentHeight / 16)),
                        child: Text("All")),
                    Spacer(),
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Color.fromARGB(255, 2, 107, 194)),
                            backgroundColor: Colors.white,
                            primary: greyText,
                            fixedSize:
                                Size(currentWidth / 3.5, currentHeight / 16)),
                        child: Text("Male")),
                    Spacer(),
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Color.fromARGB(255, 2, 107, 194)),
                            backgroundColor: Colors.white,
                            primary: greyText,
                            fixedSize:
                                Size(currentWidth / 3.5, currentHeight / 16)),
                        child: Text("Female"))
                  ],
                ),
              ),

              //------------------------------------------------------------------
              SizedBox(
                height: 20,
              ),

              Text(
                "Join Settings",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: greyText,
                ),
              ),

              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            primary: greyText,
                            backgroundColor: Colors.white,
                            fixedSize:
                                Size(currentWidth / 2.3, currentHeight / 18)),
                        child: Text(
                          "Anyone Can Join",
                          style: TextStyle(color: greyText),
                        )),
                    Spacer(),
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            primary: greyText,
                            backgroundColor: Colors.white,
                            fixedSize:
                                Size(currentWidth / 2.3, currentHeight / 18)),
                        child: Text(
                          "Request to Join",
                          style: TextStyle(color: greyText),
                        ))
                  ],
                ),
              ),

              //-------------------------------------------------------------------

              SizedBox(
                height: 20,
              ),

              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "No. of Spots",
                        style: TextStyle(
                            color: greyText, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        width: currentWidth / 1.7,
                        height: currentHeight / 17,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: IconButton(
                                    iconSize: 18,
                                    onPressed: () {},
                                    icon: Icon(Icons.remove)),
                              ),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  "05",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: greyText),
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                child: IconButton(
                                    iconSize: 18,
                                    onPressed: () {},
                                    icon: Icon(Icons.add)),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ),

              //--------------------------------------------------------------------

              Spacer(),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                    fixedSize: Size(currentWidth, currentHeight / 14),
                  ),
                  child: Text("POST"))
            ]),
      ),
    );
  }
}
