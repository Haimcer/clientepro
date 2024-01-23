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
