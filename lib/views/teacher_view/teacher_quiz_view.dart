import 'dart:developer';

import 'package:ai_classmate/controllers/auth_controller.dart';
import 'package:ai_classmate/core/components/app_tile.dart';
import 'package:ai_classmate/core/components/snackbar.dart';
import 'package:ai_classmate/core/const.dart';
import 'package:ai_classmate/core/db.dart';
import 'package:ai_classmate/views/auth_views/auth_options_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/admin_controller.dart';
import '../../core/app_navigator.dart';
import '../../core/theme.dart';
import 'teacher_add_new/add_new_tabs_view.dart';

class TeacherQuizView extends StatelessWidget {
  TeacherQuizView({super.key});

  final authCtrl = Get.put(AuthController());
  final adminCtrl = Get.find<AdminController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Quiz"),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                useSafeArea: true,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(adminCtrl.admin.groupId),
                            IconButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: adminCtrl.admin.groupId),
                                );
                                ksucessSnackbar(message: "Group Id Copied");
                              },
                              icon: const Icon(Icons.copy),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.supervised_user_circle),
          ),
          IconButton(
            onPressed: () {
              authCtrl.signOut(context);
              Get.offAll(() => const AuthOptionsView());
            },
            icon: const Icon(Icons.logout_outlined, size: 25),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () async {
          appNavPush(context, AddNewTabsView());
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: DB.schedules
            .where('doc_id', isEqualTo: adminCtrl.admin.groupId)
            .orderBy('date')
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? const Center(child: Text("No Quiz"))
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      return appTile(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.data!.docs[index].data()['schdule'],
                                style: Const.labelText(),
                              ),
                            ),
                            Text(
                              dateString(
                                snapshot.data!.docs[index]
                                    .data()['date']
                                    .toDate(),
                                snapshot.data!.docs[index]
                                    .data()['end_date']
                                    .toDate(),
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text("Are you sure to delete?"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  await DB.schedules
                                                      .doc(
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                            .id,
                                                      )
                                                      .delete();
                                                  Get.back();
                                                },
                                                child: const Text('Delete'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(Icons.delete, size: 20),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            print(snapshot.error);

            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }

  String dateString(DateTime st, DateTime en) {
    if (st.month == en.month) {
      return "${DateFormat('MMM d').format(st)}-${DateFormat('d').format(en)}";
    }
    return "${DateFormat('MMM d').format(st)}-${DateFormat('MMM d').format(en)}";
  }
}
