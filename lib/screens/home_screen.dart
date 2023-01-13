import 'dart:io';
import 'dart:typed_data';
import 'package:ascii_image/screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ascii_image/constants/utils.dart';
import 'package:ascii_image/resources/auth_methods.dart';
import 'package:ascii_image/resources/firestore_methods.dart';
import 'package:ascii_image/services/ascii_services.dart';
import 'package:neoansi/neoansi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AsciiServices asciiServices = AsciiServices();
  final AuthMethods authMethods = AuthMethods();
  User? user = FirebaseAuth.instance.currentUser;
  String imageUrl = "";

  final TextEditingController _userInput = TextEditingController();
  var output = "";
  bool isEnable = true;
  bool flag = true;
  var newPage;
  Options options = Options();

  followCommands(String comm) {
    if (comm == 'help') {
      var commands =
          "text\\<your text here> --> to convert your text to ASCII Image\n"
          "image --> to convert your image to ASCII Image\n"
          "logout --> to logout from your account\n";
      setState(() {
        output = commands;
      });
      newPage = const HomeScreen();
    } else if (comm == 'image') {
      selectImage();
    } else if (comm == 'logout') {
      var comm = "logging out....";
      setState(() {
        output = comm;
      });
      authMethods.logout(context);
    } else if (comm.startsWith('text\\')) {
      comm.trim();
      var userText = comm.split('text\\');
      fetchAsciiFromText(userText[1]);
    } else {
      var message = "No such command found,type /help to see all commands";
      output = message;
      newPage = const HomeScreen();
    }
  }

  void selectImage() async {
    try {
      Uint8List image = await pickImage(ImageSource.gallery);
      imageUrl = await FireStoreMethods().uploadImage(image, userData['uid']);
      fetchAsciiFromImage();
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  fetchAsciiFromImage() async {
    String ans =
        await asciiServices.uploadImageCommand(url: imageUrl, context: context);
    setState(() {
      output = ans;
      newPage = const HomeScreen();
    });
  }

  fetchAsciiFromText(String text) async {
    String ans =
        await asciiServices.uploadTextCommand(text: text, context: context);
    setState(() {
      output = ans;
      newPage = const HomeScreen();
    });
  }

  Widget takeInput() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "${userData['firstName']}${userData['secondName']}@ascii-studio \$"
                    .toLowerCase(),
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
            color: Colors.greenAccent,
            fontSize: 13.0,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          child: newPage,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return takeInput();
  }
}
