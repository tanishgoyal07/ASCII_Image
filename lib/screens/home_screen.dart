import 'dart:io';
import 'dart:typed_data';

import 'package:ansi_escapes/ansi_escapes.dart';
import 'package:ascii_image/providers/user_provider.dart';
import 'package:ascii_image/resources/firestore_methods.dart';
import 'package:ascii_image/services/ascii_services.dart';
import 'package:ascii_image/widgets/input.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ascii_image/resources/auth_methods.dart';
import 'package:ascii_image/constants/loader.dart';
import 'package:ascii_image/constants/utils.dart';
import 'package:ascii_image/model/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AsciiServices asciiServices = AsciiServices();
  final AuthMethods authMethods = AuthMethods();
  User? user = FirebaseAuth.instance.currentUser;
  var userData = {};
  bool isLoading = false;
  String imageUrl = "";

  final TextEditingController _userInput = TextEditingController();
  var output = "";
  bool isEnable = true;
  bool flag = true;
  followCommands(String comm) {
    if (comm == 'help') {
      var commands = "signup --> to sign up as a new user\n"
          "login --> to log in as an existing user\n"
          "<your text here> --> to convert your text to ASCII Image\n"
          "image --> to convert your image to ASCII Image\n"
          "download\\recent --> to download the last ASCII Image\n";
      "logout --> to logout from your account\n";
      setState(() {
        output = commands;
      });
    } else if (comm == 'image') {
      selectImage();
    } else if (comm == 'logout') {
      var comm = "logging out....";
      setState(() {
        output = comm;
      });
      authMethods.logout(context);
    } else {
      fetchAsciiFromText(comm);
    }
  }
  

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  void selectImage() async {
    try {
      Uint8List image = await pickImage(ImageSource.gallery);
      imageUrl = await FireStoreMethods().uploadImage(image, userData['uid']);
      print("check1");
      fetchAsciiFromImage();
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      output = imageUrl;
    });
  }

  fetchAsciiFromImage() async {
    print("check2");
    String ans = await asciiServices.uploadImageCommand(url: imageUrl, context: context);
    print("check4");
    setState(() {
      output = ans;
    });
  }

  fetchAsciiFromText(String text) async {
    print(text);
    String ans = await asciiServices.uploadTextCommand(text: text, context: context);
    // String ans = await asciiServices.getAnsiValue(text);
    // print(ans);
    setState(() {
      output = ans;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loader()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.grey[900],
              title: Text(
                "ASCII STUDIO",
                style: GoogleFonts.courierPrime(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Type help to view the list of commands.",
                      style: GoogleFonts.courierPrime(
                        color: GlobalVariables.mainColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  takeInput(),
                ],
              ),
            ),
          );
  }

  takeInput() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "C:\\users\\${userData['firstName']}${userData['secondName']}\\",
                  style: const TextStyle(
                    color: GlobalVariables.mainColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: 1100.0,
                  child: TextField(
                    enabled: isEnable,
                    onSubmitted: (value) {
                      followCommands(value);
                      setState(() {
                        isEnable = false;
                      });
                    },
                    controller: _userInput,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: GoogleFonts.courierPrime(
                      color: GlobalVariables.mainColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            output,
            style: GoogleFonts.courierPrime(
              color: GlobalVariables.mainColor,
              fontSize: 13.0,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
