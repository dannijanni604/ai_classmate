import 'package:ai_classmate/controllers/group_chat_controller.dart';
import 'package:ai_classmate/core/theme.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherChatView extends StatelessWidget {
  TeacherChatView({super.key});
  @override
  final ctrl = Get.put(ChatController());

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Group Chat"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: ctrl.fireStore
                .collection("chat")
                .orderBy('sendAt', descending: true)
                .snapshots(),
            builder:
                (
                  context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                ) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(12),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ctrl.isauth =
                              ctrl.currentUserID ==
                              snapshot.data!.docs[index]['uid'];
                          return Column(
                            children: [
                              // IconButton(
                              //     onPressed: () {
                              //       FirebaseFirestore.instance
                              //           .collection('chat')
                              //           .doc(snapshot.data!.docs[index].id)
                              //           .delete();
                              //     },
                              //     icon: const Icon(
                              //       Icons.delete,
                              //     )),
                              ChatChip(
                                chat: snapshot.data!.docs[index].data(),
                                ctrl: ctrl,
                              ),
                            ],
                          );
                        },
                        reverse: true,
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ctrl.auth.currentUser != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          ctrl.picDocuments();
                        },
                        child: const Icon(
                          Icons.attachment_rounded,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    )
                  : SizedBox(width: 5),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontSize: 14),
                  controller: ctrl.messageController,
                  maxLines: null,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    hintText: "Write Your Message",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () async {
                    if (ctrl.messageController.text.isNotEmpty) {
                      final name = await ctrl.getUserName();
                      await ctrl.fireStore.collection("chat").doc().set({
                        'name': name,
                        'uid': ctrl.currentUserID,
                        'message': ctrl.messageController.text,
                        'type': "text",
                        'sendAt': FieldValue.serverTimestamp(),
                      });
                      ctrl.messageController.clear();
                    }
                  },
                  child: const Icon(Icons.send, color: Colors.black, size: 28),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class ChatChip extends StatelessWidget {
  final Map<String, dynamic> chat;
  final ChatController ctrl;

  ChatChip({required this.chat, required this.ctrl, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSender = ctrl.isauth;
    final bool isText = chat['type'] == 'text';
    final bool isDoc = chat['type'] == 'doc';
    final bool showLeftAvatar = !isSender && ctrl.pickedDocuments.isNotEmpty;
    final bool showRightAvatar = isSender && !isDoc;

    return Column(
      crossAxisAlignment: isSender
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        if (!isSender)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Text(
              chat['name'] ?? 'Unknown',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: isSender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (showLeftAvatar) _buildAvatar(),
            if (isText)
              BubbleSpecialOne(
                delivered: true,
                text: chat['message'] ?? "",
                isSender: isSender,
                color: Colors.purple.shade100,
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              _buildImageBubble(chat['message']),
            if (showRightAvatar) _buildAvatar(),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      height: 30,
      width: 30,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Icon(Icons.person, color: Colors.white, size: 20),
    );
  }

  Widget _buildImageBubble(List<dynamic> images) {
    return Column(
      children: images
          .map<Widget>(
            (e) => Container(
              height: 200,
              width: 150,
              margin: const EdgeInsets.all(4),
              child: Image.network(e.toString(), fit: BoxFit.cover),
            ),
          )
          .toList(),
    );
  }
}
