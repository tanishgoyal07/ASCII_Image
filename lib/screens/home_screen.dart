import 'package:ascii_image/auth/auth_methods.dart';
import 'package:ascii_image/constants/loader.dart';
import 'package:ascii_image/constants/utils.dart';
import 'package:ascii_image/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  // UserModel loggedInUser = UserModel();
  var userData = {};
  bool isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    // return isLoading
    //     ? const Loader()
    //     : Scaffold(
    //         backgroundColor: GlobalVariables.secondaryColor,
    //         appBar: AppBar(
    //           title: const Text("Welcome"),
    //           centerTitle: true,
    //           // backgroundColor: Colors.transparent,
    //           // elevation: 0.0,
    //         ),
    //         body: Center(
    //           child: Padding(
    //             padding: const EdgeInsets.all(20),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: <Widget>[
    //                 SizedBox(
    //                   height: 150,
    //                   child: Image.asset(
    //                     "assets/logo2.png",
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //                 const Text(
    //                   "Welcome Back",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                     color: GlobalVariables.mainColor,
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 10,
    //                 ),
    //                 Text(
    //                   "${userData['firstName']} ${userData['secondName']}",
    //                   style: const TextStyle(
    //                     color: GlobalVariables.mainColor,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //                 Text("${userData['email']}",
    //                     style: const TextStyle(
    //                       color: GlobalVariables.mainColor,
    //                       fontWeight: FontWeight.w500,
    //                     )),
    //                 const SizedBox(
    //                   height: 15,
    //                 ),
    //                 ActionChip(
    //                   label: const Text(
    //                     "Logout",
    //                     style: TextStyle(
    //                       color: GlobalVariables.secondaryColor,
    //                     ),
    //                   ),
    //                   onPressed: () => AuthMethods().logout(context),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    return isLoading
        ? const Loader()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
                backgroundColor: Colors.grey[900],
                title: Text(
                  "Command Prompt",
                  style: GoogleFonts.courierPrime(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Center(
                      child: BlinkText(
                        'WELCOME!',
                        style: TextStyle(
                          fontSize: 35.0,
                          color: GlobalVariables.mainColor,
                        ),
                        endColor: Colors.black,
                        //duration: Duration(seconds: 1),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        "Microsoft Windows [Version 10.0.22621.963]",
                        style: TextStyle(
                          color: GlobalVariables.mainColor,
                          fontSize: 13,
                        ),
                      ),
                      const Text(
                        "(c) Microsoft Corporation. All rights reserved.",
                        style: TextStyle(
                          color: GlobalVariables.mainColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: const Text(
                      '!!Convert an Image to Image made up of ASCII values!!',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: GlobalVariables.mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: const Text(
                      'Convert text to ASCII image',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: GlobalVariables.mainColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MaterialButton(
                    color: Colors.grey,
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: 100,
                    onPressed: () {},
                    child: Text(
                      "Click Here",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.courierPrime(
                        fontSize: 20,
                        color: GlobalVariables.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: const EdgeInsets.all(2.0),
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Convert image to ASCII image',
                      style: GlobalVariables.customStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MaterialButton(
                    color: Colors.grey,
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: 100,
                    onPressed: () {},
                    child: Text(
                      "Click Here",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.courierPrime(
                        fontSize: 20,
                        color: GlobalVariables.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  // the logout function
}
