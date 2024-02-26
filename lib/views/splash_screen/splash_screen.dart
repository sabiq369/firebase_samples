import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:mastering_firebase/views/dashboard/home_page.dart';
import 'package:mastering_firebase/views/login/login.dart';

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
              if (FirebaseAuth.instance.currentUser != null) {
                Get.off(() => const HomePage());
              } else {
                Get.off(() => Login());
              }
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
}
