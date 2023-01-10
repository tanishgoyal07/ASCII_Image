import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalVariables {
  static const mainColor = Color(0xffc2ef11);
  static const secondaryColor = Colors.black;

  static TextStyle customStyle = GoogleFonts.courierPrime(
    color: GlobalVariables.mainColor,
  );
}

showSnackBar(String content ,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content)
    )
  );
}