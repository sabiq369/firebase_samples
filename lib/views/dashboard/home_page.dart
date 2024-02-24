import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mastering_firebase/utils/widgets/common_functions.dart';
import 'package:mastering_firebase/views/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
          onPressed: () async {
            try {
              await FirebaseAuth.instance.signOut();
              showToast(msg: "Successfully logged out.");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Get.offAll(() => Login());
            } catch (e) {
              showToast(msg: e.toString());
            }
          },
          child: Text('Sign out'),
        ),
        SizedBox(width: 10)
      ]),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
