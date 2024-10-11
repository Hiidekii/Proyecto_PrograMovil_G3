import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingController extends GetxController {
  void onContinueClick(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }
}
