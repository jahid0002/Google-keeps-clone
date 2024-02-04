import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:keeps/all_pages/home/home_page.dart';
import 'package:keeps/all_pages/login/login_page.dart';

class SpalashController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    if (user == null) {
      Timer(const Duration(seconds: 3), () {
        Get.off(() => const LoginPage());
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Get.off(() => const HomePage());
      });
    }
  }
}
