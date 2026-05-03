import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/constants/api_constants.dart';
import '../models/prediction_model.dart';

class OpenAiDatasource {
  final http.Client client;

  OpenAiDatasource({required this.client});

  Future<PredictionModel> getTechPrediction(String prompt) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('OPENAI_API_KEY is not set in .env');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = json.encode({
      "model": "gpt-4o-mini",
      "response_format": { "type": "json_object" },
      "messages": [
        {
          "role": "system",
          "content": "You are a tech analyst. Return ONLY a valid JSON object with keys: techName, forecastScore (number), reasoning."
        },
        {
          "role": "user",
          "content": prompt
        }
      ]
    });

    try {
      final response = await client.post(
        Uri.parse(ApiConstants.openaiChatCompletions),
        headers: headers,
        body: body,
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final contentStr = decoded['choices'][0]['message']['content'];
        final Map<String, dynamic> contentJson = json.decode(contentStr);
        return PredictionModel.fromJson(contentJson);
      } else {
        throw Exception('OpenAI API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get prediction: $e');
    }
  }
}
