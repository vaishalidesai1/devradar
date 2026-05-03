import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';

class DevToRemoteDatasource {
  final http.Client client;

  DevToRemoteDatasource({required this.client});

  Future<List<Map<String, dynamic>>> getTopArticles() async {
    return _fetchArticles('${ApiConstants.devtoArticles}?top=7');
  }

  Future<List<Map<String, dynamic>>> getFlutterArticles() async {
    return _fetchArticles('${ApiConstants.devtoArticles}?tag=flutter&per_page=10');
  }

  Future<List<Map<String, dynamic>>> _fetchArticles(String url) async {
    try {
      final response = await client.get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
          
      if (response.statusCode == 200) {
        final List<dynamic> decoded = json.decode(response.body);
        return decoded.map((e) {
          final map = e as Map<String, dynamic>;
          return {
            'title': map['title'],
            'description': map['description'],
            'tag_list': map['tag_list'],
            'positive_reactions_count': map['positive_reactions_count'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load Dev.to articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching from Dev.to: $e');
    }
  }
}
