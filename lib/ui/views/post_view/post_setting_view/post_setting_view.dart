import 'package:flutter/material.dart';

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
      backgroundColor: Color.fromARGB(255, 194, 204, 212),
      appBar: AppBar(
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
          children: [
          Container(
            width: currentWidth,
            height: currentHeight/3,
            decoration: BoxDecoration(
              color: Colors.red,),
           child: Image.network("https://i.pinimg.com/originals/c3/ca/06/c3ca061c76916b171df4d48278a6e00a.png",fit: BoxFit.cover,),
          ),
          
          SizedBox(height: 20),

          //-------------------------
          Text("Show to",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[800]
          ),),
          SizedBox(height: 5,),
          Row(
            children: [
              OutlinedButton(onPressed: (){

              }, 
              
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color.fromARGB(255, 2, 107, 194)),
                backgroundColor: Colors.white,
                primary: Colors.grey[600],
                fixedSize: Size(currentWidth/3.5, currentHeight/16)
              ),
              child: Text("All")),
              Spacer(),
              OutlinedButton(onPressed: (){

              }, 
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color.fromARGB(255, 2, 107, 194)),
                backgroundColor: Colors.white,
                primary: Colors.grey[600],
                fixedSize: Size(currentWidth/3.5, currentHeight/16)
              ),
              child: Text("Male")),
              Spacer(),
              OutlinedButton(onPressed: (){

              }, 
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color.fromARGB(255, 2, 107, 194)),
                backgroundColor: Colors.white,
                primary: Colors.grey[600],
                fixedSize: Size(currentWidth/3.5, currentHeight/16)
              ),
              child: Text("Female"))
            ],
          ),

        //------------------------------------------------------------------
        SizedBox(height: 20,),

        Text("Join Settings",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
            
          ),),
        SizedBox(height: 5,),
        Row(
          children: [
            OutlinedButton(onPressed: (){

            }, 
            style: OutlinedButton.styleFrom(
              primary: Colors.grey[600],
              backgroundColor: Colors.white,
              fixedSize: Size(currentWidth/2.3, currentHeight/18)
            ),
            child: Text("Anyone Can Join")),
            Spacer(),
            OutlinedButton(onPressed: (){

            }, 
            style: OutlinedButton.styleFrom(
              primary: Colors.grey[600],
              backgroundColor: Colors.white,
              fixedSize: Size(currentWidth/2.3, currentHeight/18)
            ),
            child: Text("Request to Join"))
          ],
        ),

        //-------------------------------------------------------------------

        SizedBox(height: 20,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text("No. of Spots",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w500
            ),),
          
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
            ),
            width: currentWidth/1.7,
            height: currentHeight/17,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              IconButton(
                iconSize: 18,
                onPressed: (){

              }, icon: Icon(Icons.remove)),

              Spacer(),
              Text("05",style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]),),
              Spacer(),

              IconButton(
                iconSize: 18,
                onPressed: (){

              }, icon: Icon(Icons.add))

            ]), 
          )
        ],),
          
      //--------------------------------------------------------------------

      Spacer(),
      ElevatedButton(
        onPressed: (){

      }, 
      style: ElevatedButton.styleFrom(
        primary: Colors.blue[900],
        fixedSize: Size(currentWidth,currentHeight/14),
      ),
      child: Text("POST"))


          
        ]),
      ),
    );
  }
}
