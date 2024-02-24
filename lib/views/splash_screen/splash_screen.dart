import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:mastering_firebase/utils/common.dart';
import 'package:mastering_firebase/views/dashboard/home_page.dart';
import 'package:mastering_firebase/views/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  // 252523
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 1700)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              getPreference();
            });
          }
          return SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Lottie.asset('assets/firebase_splash.json',
                    repeat: false,
                    height: MediaQuery.of(context).size.height * 0.4),
              ),
            ),
          );
        },
      ),
    );
  }

  getPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Common.loginStatus) == "1") {
      Get.off(
        () => const HomePage(),
        duration: const Duration(milliseconds: 2500),
      );
    } else {
      Get.off(
        () => Login(),
        duration: const Duration(milliseconds: 2500),
      );
    }
  }
}
