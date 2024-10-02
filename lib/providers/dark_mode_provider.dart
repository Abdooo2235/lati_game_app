import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvider with ChangeNotifier {
  bool isDark = false;

  switchMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isDark = !isDark;
    prefs.setBool('darkMode', isDark);
    notifyListeners();
  }

  getMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('isDark') ?? false;
    notifyListeners();
    // (prefs.getBool("isDark") == null ? false : prefs.getBool("isDark"))!;
  }
}