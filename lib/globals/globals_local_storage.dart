import 'package:shared_preferences/shared_preferences.dart';

class GlobalsLocalStorage {
  Future<bool> isPageViewed(String pageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(pageId);
  }

  Future<void> markPageAsViewed(String pageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(pageId, true);
  }

  Future<List<String>?> getFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? favoritos = prefs.getStringList('listFavorites');
    return favoritos;
  }

  Future<void> setFavorite({required List<String> listFavorite}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('listFavorites', listFavorite);
  }

  Future<List<String>?> getDownloads() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? listDownloads = prefs.getStringList('Downloads');
    return listDownloads;
  }

  Future<void> setDawmloads({required List<String> listDownloads}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('Downloads', listDownloads);
  }

  Future<void> setId(String fcmToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idFCM', fcmToken);
  }

  Future<bool> verifyId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('idFCM');
  }

  Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idFCM');
  }
}
