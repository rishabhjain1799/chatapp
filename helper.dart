import 'package:shared_preferences/shared_preferences.dart';

class Helperfunctions
{
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

static Future<void> saveuserLoggedInsharedPreference(bool isUserLoggedIn) async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
}

static Future<void> saveuserNamesharedPreference(String userName) async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(sharedPreferenceUserNameKey, userName);
}

static Future<void> saveUserEmailsharedPrefernce(String userEmail) async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
}

static Future<bool> getUserLoggedInsharedPreference() async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(sharedPreferenceUserLoggedInKey);
}

static Future<String> getUserNamesharedPreference() async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(sharedPreferenceUserNameKey);
}

static Future<String> getUserEmailsharedPreference() async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(sharedPreferenceUserEmailKey);
}

}