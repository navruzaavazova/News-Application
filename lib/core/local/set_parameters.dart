import 'package:shared_preferences/shared_preferences.dart';

class SetParameters {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    if (_prefs == null) {
      throw Exception("SharedPreferences weren't init");
    }
    return _prefs!;
  }

  static Future<void> saveLanguage(String lang) async {
    await _instance.setString('selectedLanguage', lang);
  }

  static String getSavedLanguage() {
    return _instance.getString('selectedLanguage') ?? 'us';
  }

  static Future<void> saveCategory(String cat) async {
    await _instance.setString('selectedCategory', cat);
  }

  static String getSavedCategory() {
    return _instance.getString('selectedCategory') ?? 'General';
  }

  static void cleanSharedPref(){
    _instance.clear();
  }


}
