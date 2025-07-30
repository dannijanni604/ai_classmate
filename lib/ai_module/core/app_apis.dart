import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String apiKey = dotenv.env['AI_KEY'] ?? '';

const String baseURL = "https://api.openai.com/v1";

String endPoint(String endPoint) => "$baseURL/$endPoint";

Map<String, String> headerBearerOption(String token) => {
  "Content-Type": "application/json",
  'Authorization': 'Bearer $token',
};

enum ApiState { loading, success, error, notFound }

class ChatGptApi {
  Future<String> getMessageFromChatGPT(String message) async {
    try {
      final response = await http.post(
        Uri.parse(endPoint("chat/completions")),
        headers: headerBearerOption(apiKey),
        body: jsonEncode({
          "model": "gpt-4.1-nano",
          "messages": [
            {"role": "user", "content": message},
          ],
          "temperature": 0.3,
          "max_tokens": 500,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return decoded["choices"][0]["message"]["content"].toString().trim();
      } else {
        return "Error: ${decoded['error']['message']}";
      }
    } catch (e) {
      return "Failed to connect to OpenAI: $e";
    }
  }
}
