import '../../core/errors/failures.dart';
import '../datasources/github_remote_datasource.dart';
import '../datasources/devto_remote_datasource.dart';
import '../models/trending_repo_model.dart';

class GithubRepositoryImpl {
  final GithubRemoteDatasource githubDatasource;
  final DevToRemoteDatasource devtoDatasource;

  GithubRepositoryImpl({
    required this.githubDatasource,
    required this.devtoDatasource,
  });

  Future<List<TrendingRepoModel>> getTrendingRepos() async {
    try {
      return await githubDatasource.getTrendingRepositories();
    } catch (e) {
      throw ServerFailure('Failed to fetch trending repositories: $e');
    }
  }

  Future<List<TrendingRepoModel>> getFlutterRepos() async {
    try {
      return await githubDatasource.getFlutterRepositories();
    } catch (e) {
      throw ServerFailure('Failed to fetch Flutter repositories: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getDevToTopArticles() async {
    try {
      return await devtoDatasource.getTopArticles();
    } catch (e) {
      throw ServerFailure('Failed to fetch top articles: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getDevToFlutterArticles() async {
    try {
      return await devtoDatasource.getFlutterArticles();
    } catch (e) {
      throw ServerFailure('Failed to fetch Flutter articles: $e');
    }
  }
}
