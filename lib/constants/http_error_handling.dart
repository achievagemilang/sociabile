import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sociabile/constants/utility.dart';

void httpErrorHandling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
    case 201:
    case 202:
    case 203:
      onSuccess();
      break;

    case 400:
      showSnackbar(context, jsonDecode(response.body)['message'][0], false);
      break;

    case 500:
      showSnackbar(context, jsonDecode(response.body)['error'], false);
      break;

    default:
      showSnackbar(
        context,
        (response.body),
        false,
      );
  }
}
