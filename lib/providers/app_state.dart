import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String? responseData;

  void setResponseData(String data) {
    responseData = data;
    notifyListeners();
  }
}
