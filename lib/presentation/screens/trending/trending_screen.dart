import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/trending_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/repo_card.dart';
import '../../widgets/article_card.dart';
import '../../widgets/shimmer_card.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildHeader(context),
          _buildFilterChips(context),
          _buildReposSection(context),
          _buildArticlesSection(context),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DevRadar 🚀',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 28,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Lo que está ardiendo en tech hoy',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Consumer<TrendingProvider>(
              builder: (_, p, __) => IconButton(
                onPressed: () => p.filter == 'flutter'
                    ? p.setFilter('flutter')
                    : p.setFilter('all'),
                icon: p.isLoading
                    ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                      )
                    : const Icon(Icons.refresh_rounded, color: AppColors.textSecondary),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surfaceAlt,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<TrendingProvider>(
        builder: (_, provider, __) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
          child: Row(
            children: [
              _FilterChip(
                label: '🔥 Todo',
                selected: provider.filter == 'all',
                onTap: () => provider.setFilter('all'),
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: '💙 Flutter',
                selected: provider.filter == 'flutter',
                onTap: () => provider.setFilter('flutter'),
                color: AppColors.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReposSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer2<TrendingProvider, FavoritesProvider>(
        builder: (_, trending, favorites, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Row(
                  children: [
                    const Text('⭐ ', style: TextStyle(fontSize: 16)),
                    Text('Repositorios', style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    Text('${trending.repos.length} repos',
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ),
              if (trending.isLoading)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 4,
                  itemBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: ShimmerCard(),
                  ),
                )
              else if (trending.error != null)
                _ErrorWidget(message: trending.error!)
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: trending.repos.length,
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RepoCard(
                      repo: trending.repos[i],
                      isFavorite: favorites.isFavorite(trending.repos[i].id),
                      onFavoriteToggle: () => favorites.toggleFavorite(trending.repos[i]),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildArticlesSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<TrendingProvider>(
        builder: (_, provider, __) {
          if (provider.articles.isEmpty) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Row(
                  children: [
                    const Text('📝 ', style: TextStyle(fontSize: 16)),
                    Text('Artículos Dev.to', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: provider.articles.length,
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ArticleCard(article: provider.articles[i]),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? color : AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(24),
          boxShadow: selected
              ? [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            const Text('😅', style: TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text('Algo salió mal', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
