import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

String uri = ' http://localhost:8000/v1/ascii';

class GlobalVariables {
  static const mainColor = Color(0xffc2ef11);
  static const secondaryColor = Colors.black;
  static const text = "C:\\users\\";

  static TextStyle customStyle = GoogleFonts.courierPrime(
    color: GlobalVariables.mainColor,
  );
}

pickImage(ImageSource src) async{
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: src);

  if(file != null){
    return await file.readAsBytes();
  }
}

showSnackBar(String content ,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content)
    )
  );
}
