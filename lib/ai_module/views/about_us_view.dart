import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      const Text(
                        "About Us",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 60.w),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  const Text(
                    "This app is the result of a journey filled with hard work and determination during our final year of studies. It shows the dedication and teamwork of a group of students who came together with a shared goal. Each member brought their own skills and ideas to create something meaningful through this project.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ),

                  SizedBox(height: 20.h),
                  const Text(
                    "Muhammad bin Amin ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  const Text(
                    "Muhammad Huraira",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),

                  SizedBox(
                    height: 60.h,
                    child: Image.asset("assets/icons/ai.png"),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              width: 360.w,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(10, 35, 104, 1),
                    Color.fromRGBO(134, 0, 27, 1),
                  ],
                  begin: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: const Text(
                  "Project Created as a Final Year Project \n All Rights Reserved",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
