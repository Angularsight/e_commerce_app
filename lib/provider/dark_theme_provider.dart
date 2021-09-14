


import 'package:e_commerce_app/models/dark_theme_preferences.dart';
import 'package:flutter/cupertino.dart';

//ChangeNotifier is used to listen to a change which will used to activate the dark mode
class DarkThemeProvider with ChangeNotifier{
  //This is for storing the theme status of the app so that when it is pushed into background it will not be destroyed
  DarkThemePreferences darkThemePreferences = DarkThemePreferences();

  //Coz primarily white theme will be active
  bool _darkTheme = false;
  //getter
  bool get darkTheme => _darkTheme;

  //setter
  set darkTheme (bool value)
  {
    _darkTheme = value;
    darkThemePreferences.setDarkTheme(value);
    notifyListeners();
  }

}