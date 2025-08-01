import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ai_classmate/controllers/admin_controller.dart';
import 'package:ai_classmate/controllers/manage_assignment_controller.dart';
import 'package:ai_classmate/core/components/app_button.dart';
import 'package:ai_classmate/core/components/app_tile.dart';
import 'package:ai_classmate/core/components/snackbar.dart';
import 'package:ai_classmate/core/const.dart';
import 'package:ai_classmate/core/db.dart';
import 'package:ai_classmate/views/teacher_view/teacher_manage/teacher_document_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherManageAssignmentsView extends StatelessWidget {
  TeacherManageAssignmentsView({super.key});
  final adminCtrl = Get.find<AdminController>();
  final ctrl = Get.put(ManageAssignmentController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: DB.tasks
          .where('status', isEqualTo: "processing")
          .where('doc_id', isEqualTo: adminCtrl.admin.groupId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.docs.isEmpty
              ? const Center(child: Text("No Task"))
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (((context, index) {
                    return appTile(
                      onpress: () {
                        showDialogToCompleteTask(
                          context,
                          index,
                          ctrl,
                          snapshot,
                        );
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!.docs[index].data()['task'],
                                style: Const.labelText(),
                              ),
                              Text(
                                snapshot.data!.docs[index]
                                    .data()['submitted_at']
                                    .toDate()
                                    .toString()
                                    .substring(0, 19),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                ' Submited by : ${snapshot.data!.docs[index].data()['submitted_by'].toString().toUpperCase().capitalizeFirst} ',
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

Future showDialogToCompleteTask(
  BuildContext context,
  int index,
  ManageAssignmentController ctrl,
  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
) async {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Get.size.height * 0.02),
              Row(
                children: [
                  Text("Task :", maxLines: 2, style: Const.labelText()),
                  Text(
                    " ${snapshot.data!.docs[index].data()['task']}",
                    maxLines: 2,
                  ),
                ],
              ),
              SizedBox(height: Get.size.height * 0.01),
              Row(
                children: [
                  Text("Submited By : ", style: Const.labelText()),
                  Text(
                    " ${snapshot.data!.docs[index].data()['submitted_by'].toString().toUpperCase().capitalizeFirst}",
                  ),
                ],
              ),
              SizedBox(height: Get.size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Documents :",
                      maxLines: 2,
                      style: Const.labelText(),
                    ),
                  ),
                  kAppButton(
                    onPressed: () {
                      var urls = snapshot.data!.docs[index].data()['documents'];
                      Get.to(() => DocumentView(decoments: urls, ctrl: ctrl));
                    },
                    label: "View",
                  ),
                ],
              ),
              SizedBox(height: Get.size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  kAppButton(
                    onPressed: () {
                      DB.tasks.doc(snapshot.data!.docs[index].id).update({
                        'status': "approved",
                      });
                      Get.back();
                      ksucessSnackbar(message: "Approved Assignment");
                    },
                    label: "Accept",
                    color: Colors.green.shade400,
                  ),
                  kAppButton(
                    onPressed: () {
                      DB.tasks.doc(snapshot.data!.docs[index].id).update({
                        'status': null,
                      });
                      Get.back();
                      ksucessSnackbar(message: "Disapproved Assignment");
                    },
                    label: "Reject",
                    color: Colors.red.shade400,
                  ),
                ],
              ),
              SizedBox(height: Get.size.height * 0.08),
              SizedBox(
                width: Get.size.width * 5,
                child: kAppButton(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  label: "Back",
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
