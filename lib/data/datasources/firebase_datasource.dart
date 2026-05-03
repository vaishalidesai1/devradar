import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/favorite_model.dart';
import '../models/prediction_model.dart';
import '../models/language_stat_model.dart';

class FirebaseDatasource {
  final FirebaseFirestore firestore;

  FirebaseDatasource({required this.firestore});

  // Favorites
  Future<void> addFavorite(FavoriteModel favorite) async {
    await firestore.collection('favorites').doc('${favorite.repoId}').set(favorite.toMap());
  }

  Future<List<FavoriteModel>> getFavorites(String userId) async {
    final query = await firestore.collection('favorites')
        .where('userId', isEqualTo: userId)
        .get();
    return query.docs.map((doc) => FavoriteModel.fromJson(doc.data())).toList();
  }

  Future<void> removeFavorite(int repoId) async {
    await firestore.collection('favorites').doc('$repoId').delete();
  }

  // Predictions
  Future<void> addPrediction(PredictionModel prediction) async {
    await firestore.collection('predictions').add(prediction.toMap());
  }

  Future<List<PredictionModel>> getPredictions() async {
    final query = await firestore.collection('predictions').get();
    return query.docs.map((doc) => PredictionModel.fromJson(doc.data())).toList();
  }

  Future<void> updatePrediction(String docId, PredictionModel updatedModel) async {
    await firestore.collection('predictions').doc(docId).update(updatedModel.toMap());
  }

  Future<void> deletePrediction(String docId) async {
    await firestore.collection('predictions').doc(docId).delete();
  }

  // Language History
  Future<void> addLanguageStat(LanguageStatModel stat) async {
    await firestore.collection('language_history').add(stat.toMap());
  }

  Future<List<LanguageStatModel>> getLanguageStats(String language) async {
    final query = await firestore.collection('language_history')
        .where('language', isEqualTo: language)
        .get();
    return query.docs.map((doc) => LanguageStatModel.fromJson(doc.data())).toList();
  }
}
