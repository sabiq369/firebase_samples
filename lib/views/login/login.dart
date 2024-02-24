import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mastering_firebase/controllers/registration_controllers.dart';
import 'package:mastering_firebase/utils/common.dart';
import 'package:mastering_firebase/utils/widgets/color_constants.dart';
import 'package:mastering_firebase/utils/widgets/common_functions.dart';
import 'package:mastering_firebase/utils/widgets/textField.dart';
import 'package:mastering_firebase/views/dashboard/home_page.dart';
import 'package:mastering_firebase/views/login/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final UserRegistrationControllers userRegistrationControllers =
      Get.put(UserRegistrationControllers());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.appColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: ColorConstants.appColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Mastering Firebase',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                ExtractedTextField(
                  hintText: "Enter Your Email",
                  controller: emailController,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                ExtractedTextField(
                  hintText: "Enter Your Password",
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  showSuffixIcon: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ),
                Obx(() {
                  return ElevatedButton(
                    onPressed: () async {
                      userRegistrationControllers.loginLoading.value = true;
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        showToast(msg: "Successfully logged in.");
                        userRegistrationControllers.loginLoading.value = false;
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString(Common.loginStatus, "1");
                        Get.offAll(() => const HomePage());
                      } catch (e) {
                        showToast(msg: e.toString());
                        userRegistrationControllers.loginLoading.value = false;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                    ),
                    child: userRegistrationControllers.loginLoading.value
                        ? const SizedBox(
                            width: 30,
                            height: 30,
                            child: SpinKitHourGlass(
                              color: Colors.black,
                            ),
                          )
                        : const Text(
                            '     LOGIN     ',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                  );
                }),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.white,
                    )),
                    Text(
                      '  Or With  ',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.white,
                    )),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => const HomePage());
                      },
                      icon: Image.asset(
                        "assets/google_1.png",
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        Get.to(() => const HomePage());
                      },
                      icon: Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Image.asset(
                            "assets/apple.png",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.16),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Not a user?',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TextButton(
                          onPressed: () => Get.to(
                            () => Register(),
                          ),
                          child: const Text('Register now',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
