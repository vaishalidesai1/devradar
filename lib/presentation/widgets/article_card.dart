import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ArticleCard extends StatelessWidget {
  final Map<String, dynamic> article;
  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final tags = (article['tag_list'] as List?)?.take(2).toList() ?? [];
    final reactions = article['positive_reactions_count'] ?? 0;

    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF0E6DC), width: 1.5),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📰', style: TextStyle(fontSize: 16)),
              const Spacer(),
              const Icon(Icons.favorite_rounded, size: 13, color: AppColors.primary),
              const SizedBox(width: 3),
              Text('$reactions', style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            article['title'] ?? '',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 13),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Wrap(
            spacing: 4,
            children: tags.map((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('#$t',
                style: const TextStyle(
                  fontFamily: 'Nunito', fontSize: 10,
                  fontWeight: FontWeight.w700, color: AppColors.secondary,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
