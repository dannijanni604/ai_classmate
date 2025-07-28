import 'package:ai_classmate/controllers/admin_controller.dart';
import 'package:ai_classmate/controllers/quiz_controller.dart';
import 'package:ai_classmate/core/functions.dart';
import 'package:ai_classmate/core/theme.dart';
import 'package:ai_classmate/views/teacher_view/teacher_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'teacher_assignments_view.dart';
import 'teacher_manage/teacher_manage_tabs.dart';
import 'teacher_quiz_view.dart';

class TeacherHomeView extends StatefulWidget {
  const TeacherHomeView({super.key});

  @override
  State<TeacherHomeView> createState() => _TeacherHomeViewState();
}

class _TeacherHomeViewState extends State<TeacherHomeView> {
  int pageIndex = 0;
  final ctrl = Get.put(ScheduleController());
  final adminCtrl = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: adminCtrl.obx(
        (state) => Scaffold(
          body: IndexedStack(
            index: pageIndex,
            children: [
              TeacherQuizView(),
              TeacherAssignmentsView(),
              const TeacherManageTabsView(),
              TeacherChatView(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppTheme.kprimaryColor,
            type: BottomNavigationBarType.fixed,
            onTap: (int newIndex) {
              setState(() {
                pageIndex = newIndex;
              });
            },
            currentIndex: pageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_rounded),
                label: "Quiz",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_rounded),
                label: "Assignments",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_rounded),
                label: "Manage",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                label: "Group Chat",
              ),
            ],
          ),
        ),
        onLoading: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
