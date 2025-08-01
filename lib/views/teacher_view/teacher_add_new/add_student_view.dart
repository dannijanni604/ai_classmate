import 'package:ai_classmate/controllers/add_compaigns_controller.dart';
import 'package:ai_classmate/core/components/app_button.dart';
import 'package:ai_classmate/core/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStudentView extends StatelessWidget {
  AddStudentView({super.key});

  final ctrl = Get.find<AddCompaignsConteroller>();
  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: ctrl.memberformkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Student Name"),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                controller: ctrl.memberNameController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter Student Name";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              const Text("Generate Code"),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                controller: ctrl.genetrateCodeController,
                decoration: InputDecoration(errorMaxLines: 2),
                validator: (val) {
                  return Const.validateCode(val!);
                },
              ),
              SizedBox(height: size.height * 0.37),
              Obx(() {
                return Center(
                  child: ctrl.indicator.value
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            kAppButton(
                              onPressed: () {
                                ctrl.addMember();
                              },
                              label: "Generate Student",
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            SizedBox(height: size.height * 0.04),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.cancel),
                            ),
                          ],
                        ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
