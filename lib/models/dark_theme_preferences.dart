import 'package:shared_preferences/shared_preferences.dart';



//Once the dark mode is activated it gets destroyed when pushed into background
//In order to avoid this we use SHARED PREFERENCES to store the theme state of the app
class DarkThemePreferences{
  //This const is to monitor the theme of the app
  static const THEME_STATUS = "THEMESTATUS";

  //Setting darkTheme mode
  setDarkTheme(bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  //Getting darkTheme
  Future<bool> getDarkTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //This means if it is null return false or keep the white state
    return prefs.getBool(THEME_STATUS) ?? false;
  }

  //Getting darkTheme





}