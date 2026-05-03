class TrendingRepoModel {
  final int id;
  final String name;
  final String description;
  final int stargazersCount;
  final String language;
  final String htmlUrl;

  TrendingRepoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.stargazersCount,
    required this.language,
    required this.htmlUrl,
  });

  factory TrendingRepoModel.fromJson(Map<String, dynamic> json) {
    return TrendingRepoModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      stargazersCount: json['stargazers_count'] ?? 0,
      language: json['language'] ?? 'Unknown',
      htmlUrl: json['html_url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stargazers_count': stargazersCount,
      'language': language,
      'html_url': htmlUrl,
    };
  }
}
