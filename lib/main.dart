import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart'; // Uncomment after generating firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dotenv
  await dotenv.load(fileName: ".env");
  
  // Initialize Firebase (Assuming options are configured for the platform)
  // await Firebase.initializeApp();

  runApp(const TechPulseApp());
}

class TechPulseApp extends StatelessWidget {
  const TechPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // TODO: Inject repositories and providers here
      ],
      child: MaterialApp(
        title: 'TechPulse',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(
          body: Center(
            child: Text('TechPulse Data Layer Initialized'),
          ),
        ),
      ),
    );
  }
}
