import 'dart:io';
import 'dart:ui';
import 'package:kntag/ui/views/login_view/login_view.dart';
import 'package:kntag/ui/views/profile_view/profile_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kntag/colorAndSize.dart';

class ResetPasswordtPage extends StatefulWidget {
  const ResetPasswordtPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordtPage> createState() => _ResetPasswordtPageState();
}

class _ResetPasswordtPageState extends State<ResetPasswordtPage> {
  File? image;
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  Future pickimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final temporaryImage = File(image.path);
      setState(() {
        this.image = temporaryImage;
      });
    } on PlatformException catch (e) {
      print('unable to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 17,
            color: titleColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Form(
                key: _form,
                child: Expanded(
                  flex: 3,
                  child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Email.';
                              }
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide:
                                        new BorderSide(color: Colors.white)),
                                filled: true,
                                fillColor: whiteClr,
                                hintStyle: TextStyle(color: Colors.red),
                                labelText: 'Enter Email'),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? value) {},
                            controller: _email,
                            autofocus: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide:
                                          new BorderSide(color: Colors.white)),
                                  filled: true,
                                  fillColor: whiteClr,
                                  labelText: 'Enter password'),
                              controller: _pass,
                              validator: (val) {
                                if (val!.isEmpty)
                                  return 'Please Enter password';
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide:
                                          new BorderSide(color: Colors.white)),
                                  filled: true,
                                  fillColor: whiteClr,
                                  labelText: 'Enter Confirm password'),
                              controller: _confirmPass,
                              validator: (val) {
                                if (val!.isEmpty)
                                  return 'Please Enter Confirm password';
                                if (val != _pass.text) return 'Not Match';
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginView()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: buttonBlue,
                                  onPrimary: Color.fromARGB(255, 92, 134, 168),
                                  minimumSize: Size(double.infinity, 50)),
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        ),
                      ]),
                )),
            Spacer(),

            // To validate call
            // _form.currentState.validate()
          ],
        ),
      ),
    );
  }
}
