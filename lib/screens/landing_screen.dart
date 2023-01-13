import 'package:ascii_image/constants/utils.dart';
import 'package:ascii_image/resources/auth_methods.dart';
import 'package:ascii_image/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/loader.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

var userData = {};

class _LandingScreenState extends State<LandingScreen> {
  final AuthMethods authMethods = AuthMethods();
  User? user = FirebaseAuth.instance.currentUser;
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
                  const HomeScreen(),
                ],
              ),
            ),
          );
  }
}
