import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favorites_provider.dart';
import '../../theme/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🔖 Guardados', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28)),
                  const SizedBox(height: 2),
                  Text('Tus repos favoritos', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
          Consumer<FavoritesProvider>(
            builder: (_, provider, __) {
              if (provider.favorites.isEmpty) {
                return SliverFillRemaining(
                  child: _EmptyFavorites(),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) {
                      final fav = provider.favorites[i];
                      final langColor = AppColors.forLanguage(fav.language);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.cardBg,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: const Color(0xFFF0E6DC), width: 1.5),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: langColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  _langEmoji(fav.language),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            title: Text(fav.name, style: Theme.of(context).textTheme.titleMedium),
                            subtitle: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: langColor.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    fav.language,
                                    style: TextStyle(
                                      fontFamily: 'Nunito', fontSize: 11,
                                      fontWeight: FontWeight.w700, color: langColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.star_rounded, size: 13, color: AppColors.accent),
                                const SizedBox(width: 2),
                                Text('${fav.stars}', style: Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                            trailing: GestureDetector(
                              onTap: () => provider.removeFavorite(fav.repoId),
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.bookmark_remove_rounded,
                                  size: 17, color: AppColors.primary),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: provider.favorites.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _langEmoji(String lang) {
    const map = {
      'Dart': '🎯', 'Flutter': '💙', 'Python': '🐍',
      'JavaScript': '⚡', 'TypeScript': '🔷', 'Rust': '🦀',
      'Go': '🐹', 'Swift': '🍎', 'Kotlin': '💜', 'Java': '☕',
    };
    return map[lang] ?? '💻';
  }
}

class _EmptyFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🌟', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 16),
          Text('Nada guardado aún', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'Toca el ícono 🔖 en un repo\npara guardarlo aquí',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
