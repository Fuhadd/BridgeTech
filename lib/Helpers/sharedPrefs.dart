import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String pageIndex = "PAGEINDEX";

  //save data
  Future<bool> savePageIndex(int pageNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(pageIndex, pageNumber);
  }

  Future<int?> getPageIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(pageIndex);
  }

  Future<String?> getcurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }
}
