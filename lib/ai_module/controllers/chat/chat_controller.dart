import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../core/app_apis.dart';
import '../../core/text_generation_model.dart';

class ChatTextController extends GetxController {
  List<TextCompletionData> messages = [];
  var state = ApiState.notFound.obs;

  TextEditingController searchTextController = TextEditingController();

  Future<void> getTextCompletion(String query) async {
    addMyMessage();

    state.value = ApiState.loading;

    try {
      final requestBody = {
        "model": "gpt-4.1-nano",
        "messages": _buildChatMessages(query),
        "temperature": 0.3,
        "max_tokens": 500,
      };

      final response = await http.post(
        Uri.parse(endPoint("chat/completions")),
        body: jsonEncode(requestBody),
        headers: headerBearerOption(apiKey),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final reply = decoded["choices"][0]["message"]["content"]
            .toString()
            .trim();

        addServerMessage(reply);
        state.value = ApiState.success;
      } else {
        state.value = ApiState.error;
      }
    } catch (e) {
      state.value = ApiState.error;
    } finally {
      update();
    }
  }

  /// Helper to structure the message for GPT API
  List<Map<String, String>> _buildChatMessages(String userMessage) {
    return [
      {"role": "user", "content": userMessage},
    ];
  }

  void addServerMessage(String text) {
    messages.insert(
      0,
      TextCompletionData(
        text: text,
        index: messages.length,
        finishReason: "stop",
      ),
    );
  }

  void addMyMessage() {
    final text = searchTextController.text.trim();
    if (text.isEmpty) return;

    messages.insert(
      0,
      TextCompletionData(text: text, index: -1, finishReason: ""),
    );
    searchTextController.clear();
  }
}
