import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../core/app_apis.dart';
import '../../core/image_generation_model.dart';

class ChatImageController extends GetxController {
  List<ImageGenerationData> images = [];
  var state = ApiState.notFound.obs;

  TextEditingController searchTextController = TextEditingController();

  Future<void> getGenerateImages(String query) async {
    if (query.trim().isEmpty) return;

    state.value = ApiState.loading;
    images.clear();

    try {
      final requestBody = {
        "prompt": query.trim(),
        "n": 2, // reduced number of images to minimize cost/tokens
        "size":
            "256x256", // smallest size to reduce token usage and response time
        "response_format": "url", // optional: ensure lightweight URLs
      };

      final response = await http.post(
        Uri.parse(endPoint("images/generations")),
        headers: headerBearerOption(apiKey),
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        images = ImageGenerationModel.fromJson(decoded).data;
        state.value = ApiState.success;
      } else {
        state.value = ApiState.error;
        debugPrint("Image generation failed: ${response.body}");
      }
    } catch (e) {
      state.value = ApiState.error;
      debugPrint("Image generation error: $e");
    } finally {
      update();
    }
  }

  void clearTextField() {
    searchTextController.clear();
  }
}
