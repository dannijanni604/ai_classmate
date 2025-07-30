import 'package:ai_classmate/ai_module/controllers/home/home_bindings.dart';
import 'package:ai_classmate/ai_module/views/home_view.dart';
import 'package:ai_classmate/core/app_navigator.dart';
import 'package:ai_classmate/core/components/app_button.dart';
import 'package:ai_classmate/core/theme.dart';
import 'package:ai_classmate/views/auth_views/student_login_view.dart';
import 'package:ai_classmate/views/auth_views/teacher_login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthOptionsView extends StatelessWidget {
  const AuthOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final ctrl = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Get.size.height * 0.1,
            horizontal: Get.size.width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/class_guide.png"),

              SizedBox(
                width: Get.size.width / 1.05,
                child: kAppButton(
                  onPressed: () {
                    Get.to(const AIHomeView(), binding: HomeBinding());

                    // appNavPush(context, const AIHomeView());
                  },
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "AI HELPER",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.size.height * 0.05),

              Center(
                child: Text(
                  "Use class LMS System below",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: Get.size.height * 0.05),
              SizedBox(
                width: Get.size.width / 1.05,
                child: kAppButton(
                  onPressed: () {
                    appNavPush(context, const TeacherLogin());
                  },
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 2,
                    bottom: 2,
                    right: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Login as Teacher",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      kAppButton(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        color: AppTheme.kblueColor,
                        child: const Icon(
                          Icons.arrow_right_alt_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.size.height / 30),
              const Text("- - - - - Or - - - - -"),
              SizedBox(height: Get.size.height / 30),
              SizedBox(
                width: Get.size.width / 1.05,
                child: kAppButton(
                  onPressed: () {
                    appNavPush(context, const StudentLoginView());
                  },
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 2,
                    bottom: 2,
                    right: 2,
                  ),
                  color: AppTheme.kblueColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Login as Student",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      kAppButton(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        child: const Icon(
                          Icons.arrow_right_alt_rounded,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
