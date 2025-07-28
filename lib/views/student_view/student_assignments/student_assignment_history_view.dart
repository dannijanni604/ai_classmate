import 'package:ai_classmate/core/components/app_tile.dart';
import 'package:ai_classmate/core/const.dart';
import 'package:ai_classmate/core/db.dart';
import 'package:ai_classmate/core/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class StudentAssignmentHistoryView extends StatelessWidget {
  const StudentAssignmentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = GetStorage().read('id');
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: DB.tasks
          // .orderBy('date', descending: true)
          .where('members', arrayContains: id)
          .where('status', isNotEqualTo: null)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.docs.isEmpty
              ? const Center(child: Text("No History"))
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return appTile(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data!.docs[index].data()['task'],
                            style: Const.labelText(),
                          ),
                          Text(DateFormat("MMM d").format(DateTime.now())),
                          statusChip(
                            label:
                                snapshot.data!.docs[index].data()['status'] ??
                                '',
                            color:
                                snapshot.data!.docs[index].data()['status'] ??
                                '',
                          ),
                        ],
                      ),
                    );
                  },
                );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
