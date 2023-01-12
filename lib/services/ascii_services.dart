import 'dart:convert';

import 'package:ascii_image/constants/error_handling.dart';
import 'package:ascii_image/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AsciiServices {
  Future<void> uploadTextCommand({
    required String text,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/$text'),
           headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(e.toString() , context);
    }
  }

  Future<dynamic> uploadImageCommand({
    required String url,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/file'),
           headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "url" : url,
        }),
      );
      print("check3");
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(e.toString() , context);
    }
  }
}
