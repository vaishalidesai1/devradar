import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/prediction_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/cards.dart';
import '../../widgets/shimmer_card.dart';

class PredictionsScreen extends StatelessWidget {
  const PredictionsScreen({super.key});

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
                  Text('🤖 IA Predictor', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28)),
                  const SizedBox(height: 2),
                  Text('Qué tecnología va a explotar esta semana', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 24),
                  _PredictionBody(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PredictionBody extends StatefulWidget {
  @override
  State<_PredictionBody> createState() => _PredictionBodyState();
}

class _PredictionBodyState extends State<_PredictionBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<PredictionProvider>().predictions.isEmpty) {
        context.read<PredictionProvider>().loadPrediction();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PredictionProvider>(
      builder: (_, provider, __) {
        if (provider.isLoading) {
          return Column(
            children: [
              const ShimmerCard(),
              const SizedBox(height: 12),
              const ShimmerCard(),
              const SizedBox(height: 16),
              Text('La IA está analizando tendencias...', style: Theme.of(context).textTheme.bodyMedium),
            ],
          );
        }

        if (provider.error != null) {
          return _ErrorState(
            message: provider.error!,
            onRetry: provider.loadPrediction,
          );
        }

        if (provider.predictions.isEmpty) {
          return _EmptyState(onLoad: provider.loadPrediction);
        }

        return Column(
          children: [
            ...provider.predictions.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PredictionCard(
                techName: p.techName,
                forecastScore: p.forecastScore,
                reasoning: p.reasoning,
                weekOf: p.weekOf,
              ),
            )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: provider.loadPrediction,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Nueva predicción'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.purple,
                  side: const BorderSide(color: AppColors.purple),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  textStyle: const TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onLoad;
  const _EmptyState({required this.onLoad});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Text('🔮', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 16),
          Text('¿Qué va a ser tendencia?', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'Pregúntale a la IA qué tecnología va\na explotar esta semana',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onLoad,
            icon: const Icon(Icons.auto_awesome_rounded),
            label: const Text('Predecir ahora'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              textStyle: const TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text('😔', style: TextStyle(fontSize: 50)),
          const SizedBox(height: 12),
          Text('No se pudo conectar con la IA', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text('Reintentar'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
