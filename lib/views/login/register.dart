import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mastering_firebase/controllers/registration_controllers.dart';
import 'package:mastering_firebase/utils/common.dart';
import 'package:mastering_firebase/utils/widgets/color_constants.dart';
import 'package:mastering_firebase/utils/widgets/common_functions.dart';
import 'package:mastering_firebase/utils/widgets/textField.dart';
import 'package:mastering_firebase/views/dashboard/home_page.dart';
import 'package:mastering_firebase/views/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final UserRegistrationControllers userRegistrationControllers =
      Get.find<UserRegistrationControllers>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Align(
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Text(
                  'Name',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ExtractedTextField(
                  hintText: "Enter Your Name",
                  controller: nameController,
                  focusNode: nameFocusNode,
                  fillColor: ColorConstants.appColor,
                  hintColor: Colors.white,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ExtractedTextField(
                  hintText: "Enter Your Email",
                  controller: emailController,
                  focusNode: emailFocusNode,
                  fillColor: ColorConstants.appColor,
                  hintColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Text(
                  'Password',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ExtractedTextField(
                  hintText: "Enter Your Password",
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  showSuffixIcon: true,
                  fillColor: ColorConstants.appColor,
                  hintColor: Colors.white,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ExtractedTextField(
                  hintText: "Confirm Your Password",
                  controller: confirmPasswordController,
                  focusNode: confirmFocusNode,
                  showSuffixIcon: true,
                  fillColor: ColorConstants.appColor,
                  hintColor: Colors.white,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Align(
                  child: Obx(() {
                    return ElevatedButton(
                      onPressed: () async {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          try {
                            userRegistrationControllers.registerLoading.value =
                                true;
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            userRegistrationControllers.registerLoading.value =
                                false;
                            showToast(msg: "Account created successfully");
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString(Common.loginStatus, "1");

                            Get.offAll(() => const HomePage());
                          } catch (e) {
                            userRegistrationControllers.registerLoading.value =
                                false;
                            showToast(msg: e.toString());
                          }
                        } else {
                          showToast(
                              msg:
                                  "Password mismatch, please match the password");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        fixedSize: const Size.fromHeight(50),
                      ),
                      child: userRegistrationControllers.registerLoading.value
                          ? const SizedBox(
                              width: 30,
                              height: 30,
                              child: SpinKitHourGlass(
                                color: Colors.black,
                              ),
                            )
                          : const Text(
                              '   REGISTER   ',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                    );
                  }),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Align(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: TextButton(
                            onPressed: () => Get.offAll(
                              () => Login(),
                            ),
                            child: const Text('Login now',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
