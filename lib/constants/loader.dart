import 'package:ascii_image/constants/utils.dart';
import 'package:flutter/material.dart';


class Loader extends StatelessWidget{
  const Loader({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context){
    return const CircularProgressIndicator(
      color: GlobalVariables.secondaryColor,
    );
  }
}