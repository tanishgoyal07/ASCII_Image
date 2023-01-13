import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ascii_image/constants/error_handling.dart';
import 'package:ascii_image/constants/utils.dart';

class AsciiServices {
  String ansi = "";

  Future<String> uploadTextCommand({
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
        onSuccess: () {
          final responseJson = jsonDecode(res.body);
          ansi = responseJson['ansi'];
        },
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    return ansi;
  }

  Future<String> uploadImageCommand({
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
          "url": url,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final responseJson = jsonDecode(res.body);
          ansi = responseJson['ansi'];
        },
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    return ansi;
  }
}
