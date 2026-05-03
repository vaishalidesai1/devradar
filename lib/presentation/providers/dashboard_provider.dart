import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  String _selectedLanguage = 'Flutter';
  final List<String> languages = ['Flutter', 'Python', 'Rust', 'TypeScript', 'Go'];

  String get selectedLanguage => _selectedLanguage;

  // Mock weekly data for fl_chart (replace with Firebase data later)
  Map<String, List<double>> get weeklyStars => {
    'Flutter':    [1200, 1450, 1300, 1800, 2100, 1950, 2400],
    'Python':     [3200, 3100, 3400, 3800, 4100, 3900, 4300],
    'Rust':       [800,  950,  1100, 1050, 1300, 1250, 1500],
    'TypeScript': [2100, 2300, 2200, 2600, 2800, 2700, 3000],
    'Go':         [900,  1000, 950,  1100, 1200, 1150, 1350],
  };

  List<double> get currentLanguageData => weeklyStars[_selectedLanguage] ?? [];

  void selectLanguage(String lang) {
    _selectedLanguage = lang;
    notifyListeners();
  }
}
