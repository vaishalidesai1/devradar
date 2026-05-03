import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/constants/api_constants.dart';
import '../models/trending_repo_model.dart';

class GithubRemoteDatasource {
  final http.Client client;

  GithubRemoteDatasource({required this.client});

  Future<List<TrendingRepoModel>> getTrendingRepositories() async {
    final response = await _getWithAuth(
      '${ApiConstants.githubSearchRepos}?q=stars:>500&sort=stars&order=desc&per_page=20',
    );
    return _parseRepos(response);
  }

  Future<List<TrendingRepoModel>> getFlutterRepositories() async {
    final response = await _getWithAuth(
      '${ApiConstants.githubSearchRepos}?q=language:flutter&sort=stars&order=desc',
    );
    return _parseRepos(response);
  }

  Future<http.Response> _getWithAuth(String url) async {
    final token = dotenv.env['GITHUB_TOKEN'];
    final headers = {
      'Accept': 'application/vnd.github.v3+json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await client.get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) {
        throw Exception('Failed to load GitHub data: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  List<TrendingRepoModel> _parseRepos(http.Response response) {
    try {
      final decoded = json.decode(response.body);
      final items = decoded['items'] as List;
      return items.map((e) => TrendingRepoModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Error parsing GitHub response: $e');
    }
  }
}
