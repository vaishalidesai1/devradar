import '../../core/errors/failures.dart';
import '../datasources/firebase_datasource.dart';
import '../models/favorite_model.dart';

class FavoritesRepositoryImpl {
  final FirebaseDatasource firebaseDatasource;

  FavoritesRepositoryImpl({required this.firebaseDatasource});

  Future<void> addFavorite(FavoriteModel favorite) async {
    try {
      await firebaseDatasource.addFavorite(favorite);
    } catch (e) {
      throw ServerFailure('Failed to add favorite: $e');
    }
  }

  Future<List<FavoriteModel>> getFavorites(String userId) async {
    try {
      return await firebaseDatasource.getFavorites(userId);
    } catch (e) {
      throw ServerFailure('Failed to retrieve favorites: $e');
    }
  }

  Future<void> removeFavorite(int repoId) async {
    try {
      await firebaseDatasource.removeFavorite(repoId);
    } catch (e) {
      throw ServerFailure('Failed to remove favorite: $e');
    }
  }
}
