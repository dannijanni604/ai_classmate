import 'package:ai_classmate/core/functions.dart';
import 'package:ai_classmate/views/student_view/student_assignments/student_assignment_tabs.dart';
import 'package:ai_classmate/views/student_view/student_quiz_view.dart';
import 'package:ai_classmate/views/teacher_view/teacher_chat_view.dart';
import 'package:flutter/material.dart';

class StudentTabView extends StatefulWidget {
  const StudentTabView({super.key});

  @override
  State<StudentTabView> createState() => _StudentTabViewState();
}

class _StudentTabViewState extends State<StudentTabView> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: [
            StudentQuizView(),
            StudentAssignmentTabs(),
            // StudentChatView(),
            TeacherChatView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
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
              label: "Assignment",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: "Group Chat",
            ),
          ],
        ),
      ),
    );
  }
}
