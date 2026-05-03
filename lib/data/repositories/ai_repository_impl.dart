import '../../core/errors/failures.dart';
import '../datasources/openai_datasource.dart';
import '../models/prediction_model.dart';

class AiRepositoryImpl {
  final OpenAiDatasource openAiDatasource;

  AiRepositoryImpl({required this.openAiDatasource});

  Future<PredictionModel> predictTrendingTech() async {
    try {
      const prompt = "Analyze GitHub trends and predict the next trending technology. "
          "Return JSON with techName, forecastScore, reasoning.";
      return await openAiDatasource.getTechPrediction(prompt);
    } catch (e) {
      throw ServerFailure('Failed to fetch AI prediction: $e');
    }
  }
}
