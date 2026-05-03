import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart'; // Uncomment after adding google-services.json

import 'presentation/providers/trending_provider.dart';
import 'presentation/providers/prediction_provider.dart';
import 'presentation/providers/favorites_provider.dart';
import 'presentation/providers/dashboard_provider.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  // await Firebase.initializeApp(); // Uncomment after Firebase setup
  runApp(const DevRadarApp());
}

class DevRadarApp extends StatelessWidget {
  const DevRadarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrendingProvider()),
        ChangeNotifierProvider(create: (_) => PredictionProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: MaterialApp(
        title: 'DevRadar',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const HomeScreen(),
      ),
    );
  }
}
