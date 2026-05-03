import 'package:flutter/material.dart';
import '../../data/models/favorite_model.dart';
import '../../data/models/trending_repo_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<FavoriteModel> _favorites = [];

  List<FavoriteModel> get favorites => _favorites;

  bool isFavorite(int repoId) => _favorites.any((f) => f.repoId == repoId);

  void toggleFavorite(TrendingRepoModel repo) {
    if (isFavorite(repo.id)) {
      _favorites.removeWhere((f) => f.repoId == repo.id);
    } else {
      _favorites.add(FavoriteModel(
        repoId: repo.id,
        name: repo.name,
        language: repo.language,
        stars: repo.stargazersCount,
        savedAt: DateTime.now(),
        userId: 'local_user',
      ));
    }
    notifyListeners();
  }

  void removeFavorite(int repoId) {
    _favorites.removeWhere((f) => f.repoId == repoId);
    notifyListeners();
  }
}
