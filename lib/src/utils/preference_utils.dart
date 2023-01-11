import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static SharedPreferences? _sharedPreferences;
  static PreferenceUtils? _currentInstance;

  PreferenceUtils._internal();

  factory PreferenceUtils() {
    _currentInstance = _currentInstance ?? PreferenceUtils._internal();

    return _currentInstance!;
  }

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setInt(String key, int value) async {
    return await _sharedPreferences!.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _sharedPreferences!.setDouble(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences!.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences!.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _sharedPreferences!.setStringList(key, value);
  }

  Future<bool> setSearchTerm(String value) async {
    return await _sharedPreferences!.setString("search_term", value);
  }

  void removeSearchTerm() {
    _sharedPreferences!.remove("search_term");
  }

  String? getSearchTerm() {
    return _sharedPreferences!.getString("search_term");
  }

  Future<bool> setSearchTermList(List<String> value) async {
    return await _sharedPreferences!.setStringList("search_term_list", value);
  }

  List<String>? getSearchTermList() {
    return _sharedPreferences!.getStringList("search_term_list");
  }

  Future<bool> setImage(String value) async {
    return await _sharedPreferences!.setString("image", value);
  }

  String? getImage() {
    return _sharedPreferences!.getString("image");
  }

  Future<bool> setColor(int value) async {
    return await _sharedPreferences!.setInt("color", value);
  }

  int? getColor() {
    return _sharedPreferences!.getInt("color");
  }

  int? getInt(String key) {
    return _sharedPreferences!.getInt(key);
  }

  double? getDouble(String key) {
    return _sharedPreferences!.getDouble(key);
  }

  bool? getBool(String key) {
    return _sharedPreferences!.getBool(key);
  }

  String? getString(String key) {
    return _sharedPreferences!.getString(key);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences!.getStringList(key);
  }

  Set<String> getKeys() {
    return _sharedPreferences!.getKeys();
  }
}
