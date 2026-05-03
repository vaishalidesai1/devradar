class PredictionModel {
  final String techName;
  final double forecastScore;
  final String reasoning;
  final String? weekOf;

  PredictionModel({
    required this.techName,
    required this.forecastScore,
    required this.reasoning,
    this.weekOf,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      techName: json['techName'] ?? '',
      forecastScore: (json['forecastScore'] ?? 0.0).toDouble(),
      reasoning: json['reasoning'] ?? '',
      weekOf: json['weekOf'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'techName': techName,
      'forecastScore': forecastScore,
      'reasoning': reasoning,
      if (weekOf != null) 'weekOf': weekOf,
    };
  }
}
