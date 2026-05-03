class LanguageStatModel {
  final String language;
  final String weekLabel;
  final int starsTotal;
  final int newStars;
  final int repoCount;

  LanguageStatModel({
    required this.language,
    required this.weekLabel,
    required this.starsTotal,
    required this.newStars,
    required this.repoCount,
  });

  factory LanguageStatModel.fromJson(Map<String, dynamic> json) {
    return LanguageStatModel(
      language: json['language'] ?? '',
      weekLabel: json['weekLabel'] ?? '',
      starsTotal: json['starsTotal'] ?? 0,
      newStars: json['newStars'] ?? 0,
      repoCount: json['repoCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'weekLabel': weekLabel,
      'starsTotal': starsTotal,
      'newStars': newStars,
      'repoCount': repoCount,
    };
  }
}
