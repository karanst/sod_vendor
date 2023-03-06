import 'package:fixerking/token/token_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyToken {
  static Future getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(TokenString.userid);
    return data;
  }

  static Future getPlanStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(TokenString.planStatus);
    return data;
  }
}
