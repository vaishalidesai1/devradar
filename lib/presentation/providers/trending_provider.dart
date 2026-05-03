import 'package:flutter/material.dart';
import '../../data/datasources/github_remote_datasource.dart';
import '../../data/datasources/devto_remote_datasource.dart';
import '../../data/models/trending_repo_model.dart';
import 'package:http/http.dart' as http;

class TrendingProvider extends ChangeNotifier {
  final GithubRemoteDatasource _githubDatasource;
  final DevToRemoteDatasource _devtoDatasource;

  TrendingProvider()
      : _githubDatasource = GithubRemoteDatasource(client: http.Client()),
        _devtoDatasource = DevToRemoteDatasource(client: http.Client());

  List<TrendingRepoModel> _repos = [];
  List<Map<String, dynamic>> _articles = [];
  bool _isLoading = false;
  String? _error;
  String _filter = 'all'; // 'all' | 'flutter'

  List<TrendingRepoModel> get repos => _repos;
  List<Map<String, dynamic>> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get filter => _filter;

  Future<void> loadTrending() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _repos = await _githubDatasource.getTrendingRepositories();
      _articles = await _devtoDatasource.getTopArticles();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFlutter() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _repos = await _githubDatasource.getFlutterRepositories();
      _articles = await _devtoDatasource.getFlutterArticles();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setFilter(String f) {
    _filter = f;
    notifyListeners();
    if (f == 'flutter') {
      loadFlutter();
    } else {
      loadTrending();
    }
  }
}
