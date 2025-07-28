import 'package:ai_classmate/controllers/admin_controller.dart';
import 'package:ai_classmate/core/components/app_tile.dart';
import 'package:ai_classmate/core/const.dart';
import 'package:ai_classmate/core/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/functions.dart';

class TeacherManageHistoryView extends StatelessWidget {
  TeacherManageHistoryView({super.key});
  final adminCtrl = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: DB.tasks
          .where('status', isEqualTo: 'approved')
          .where("doc_id", isEqualTo: adminCtrl.admin.groupId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.docs.isEmpty
              ? const Center(child: Text("No History"))
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (((context, index) {
                    return appTile(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!.docs[index].data()['task'],
                                style: Const.labelText(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' Submited by : ${snapshot.data!.docs[index].data()['submitted_by'].toString()}',
                              ),
                              statusChip(
                                label: snapshot.data!.docs[index]
                                    .data()['status'],
                                color: snapshot.data!.docs[index]
                                    .data()['status'],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  })),
                );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
