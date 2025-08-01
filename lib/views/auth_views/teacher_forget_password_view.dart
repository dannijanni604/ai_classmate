import 'package:ai_classmate/controllers/auth_controller.dart';
import 'package:ai_classmate/core/components/app_button.dart';
import 'package:ai_classmate/core/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherForgetPasswordView extends StatelessWidget {
  const TeacherForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final forgetEmailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final ctrl = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: Get.size.height * 0.03),
                Text("Reset Your Password", style: Const.labelText()),
                SizedBox(height: Get.size.height * 0.03),
                const Text("Enter Email Address To Reset Forgotten Password"),
                SizedBox(height: Get.size.height * 0.03),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.size.height * 0.03),
                      Text("Enter Email"),
                      SizedBox(height: Get.size.height * 0.01),
                      TextFormField(
                        controller: forgetEmailController,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter Email To Reset Password";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: Get.size.height * 0.08),
                      Center(
                        child: ctrl.onLogin.value
                            ? const CircularProgressIndicator()
                            : Obx(() {
                                return ctrl.onLogin.value
                                    ? CircularProgressIndicator()
                                    : kAppButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            ctrl.resetPassword(
                                              forgetEmailController.text,
                                            );
                                            forgetEmailController.clear();
                                          }
                                        },
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 50,
                                        ),
                                        label: "Reset",
                                      );
                              }),
                      ),
                    ],
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
