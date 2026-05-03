import 'package:flutter/material.dart';
import '../../data/models/trending_repo_model.dart';
import '../theme/app_theme.dart';

class RepoCard extends StatelessWidget {
  final TrendingRepoModel repo;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const RepoCard({
    super.key,
    required this.repo,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final langColor = AppColors.forLanguage(repo.language);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0E6DC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: langColor.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: langColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      _langEmoji(repo.language),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        repo.name,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: langColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          repo.language,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: langColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onFavoriteToggle,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isFavorite ? AppColors.primary.withValues(alpha: 0.12) : AppColors.surfaceAlt,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isFavorite ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                      size: 18,
                      color: isFavorite ? AppColors.primary : AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
            if (repo.description.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                repo.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star_rounded, size: 15, color: AppColors.accent),
                const SizedBox(width: 4),
                Text(
                  _formatStars(repo.stargazersCount),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Icon(Icons.open_in_new_rounded, size: 14, color: AppColors.textMuted),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatStars(int stars) {
    if (stars >= 1000) return '${(stars / 1000).toStringAsFixed(1)}k';
    return '$stars';
  }

  String _langEmoji(String lang) {
    const map = {
      'Dart': '🎯', 'Flutter': '💙', 'Python': '🐍',
      'JavaScript': '⚡', 'TypeScript': '🔷', 'Rust': '🦀',
      'Go': '🐹', 'Swift': '🍎', 'Kotlin': '💜',
      'Java': '☕', 'C++': '⚙️',
    };
    return map[lang] ?? '💻';
  }
}
