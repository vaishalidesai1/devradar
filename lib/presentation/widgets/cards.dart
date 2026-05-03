import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_theme.dart';

// ── ARTICLE CARD ──────────────────────────────────────────────────────────────
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

// ── PREDICTION CARD ──────────────────────────────────────────────────────────
class PredictionCard extends StatelessWidget {
  final String techName;
  final double forecastScore;
  final String reasoning;
  final String? weekOf;

  const PredictionCard({
    super.key,
    required this.techName,
    required this.forecastScore,
    required this.reasoning,
    this.weekOf,
  });

  @override
  Widget build(BuildContext context) {
    final scoreColor = forecastScore >= 70
        ? AppColors.secondary
        : forecastScore >= 40
            ? AppColors.accent
            : AppColors.primary;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.purple.withValues(alpha: 0.08),
            AppColors.primary.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.purple.withValues(alpha: 0.2), width: 1.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🤖', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Predicción IA', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.purple)),
                    Text(techName, style: Theme.of(context).textTheme.headlineMedium),
                  ],
                ),
              ),
              // Score circle
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scoreColor.withValues(alpha: 0.12),
                  border: Border.all(color: scoreColor, width: 2),
                ),
                child: Center(
                  child: Text(
                    '${forecastScore.toInt()}',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: scoreColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: forecastScore / 100,
              backgroundColor: AppColors.surfaceAlt,
              valueColor: AlwaysStoppedAnimation(scoreColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💬', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    reasoning,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          if (weekOf != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded, size: 12, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Text('Semana del $weekOf', style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
