import 'dart:developer';
import 'dart:io';

import 'package:ai_classmate/core/components/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ManageAssignmentController extends GetxController {
  RxBool isDownloading = false.obs;
  String extension = "";

  Future downloadAndOpenFile({String? url, String? fileName}) async {
    try {
      final file = await downloadFile(url, fileName);
      if (file == null) return null;
      log('Path :: ${file.path}');
      ksucessSnackbar(message: 'App Downloaded Successfully');
      // await OpenFile.open(file.path);
    } catch (e) {
      kerrorSnackbar(message: "Somthing went wrong");
    }
  }

  Future<File?> downloadFile(String? url, String? fileName) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File("${appStorage.path}/$fileName");
      final response = await Dio().get(
        url!,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration(seconds: 1),
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}
