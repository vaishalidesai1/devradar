import 'package:flutter/material.dart';
import '../../data/datasources/openai_datasource.dart';
import '../../data/models/prediction_model.dart';
import 'package:http/http.dart' as http;

class PredictionProvider extends ChangeNotifier {
  final OpenAiDatasource _datasource;

  PredictionProvider() : _datasource = OpenAiDatasource(client: http.Client());

  List<PredictionModel> _predictions = [];
  bool _isLoading = false;
  String? _error;

  List<PredictionModel> get predictions => _predictions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPrediction() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await _datasource.getTechPrediction(
        'Analyze current GitHub trends for popular languages like Flutter, Rust, TypeScript, Python, Go. '
        'Predict which technology will see the most growth next week based on community momentum. '
        'Return JSON: {techName, forecastScore (0-100), reasoning}',
      );
      _predictions = [result];
    } catch (e) {
      _error = 'No se pudo cargar la predicción. Verifica tu API key.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
