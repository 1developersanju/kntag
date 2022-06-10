import 'package:flutter/material.dart';

class CreateTagView extends StatefulWidget {
  const CreateTagView({Key? key}) : super(key: key);

  @override
  State<CreateTagView> createState() => _CreateTagViewState();
}

class _CreateTagViewState extends State<CreateTagView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 194, 204, 212),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black, 
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Create Tag",style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          PopupMenuButton(itemBuilder: (BuildContext context) =>[
            PopupMenuItem(child: Text("New...!"))
          ],)
        ],
      ),
      body: Form(child: Container()),
    );
  }
}
