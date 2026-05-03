class FavoriteModel {
  final int repoId;
  final String name;
  final String language;
  final int stars;
  final DateTime savedAt;
  final String userId;

  FavoriteModel({
    required this.repoId,
    required this.name,
    required this.language,
    required this.stars,
    required this.savedAt,
    required this.userId,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      repoId: json['repoId'] ?? 0,
      name: json['name'] ?? '',
      language: json['language'] ?? '',
      stars: json['stars'] ?? 0,
      savedAt: json['savedAt'] != null 
          ? DateTime.parse(json['savedAt']) 
          : DateTime.now(),
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'repoId': repoId,
      'name': name,
      'language': language,
      'stars': stars,
      'savedAt': savedAt.toIso8601String(),
      'userId': userId,
    };
  }
}
