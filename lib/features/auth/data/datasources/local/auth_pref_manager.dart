import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefManager {
  String kIsLogin = 'isLogin';
  String kToken = 'token';
  String kName = "name";
  String kEmail = "email";
  String kUserID = "userID";

  SharedPreferences preferences;
  AuthPrefManager(this.preferences);

  set isLogin(bool value) => preferences.setBool(kIsLogin, value);
  bool get isLogin => preferences.getBool(kIsLogin) ?? false;
  set token(String? value) => preferences.setString(kToken, value ?? '');
  String? get token => preferences.getString(kToken);
  set name(String? value) => preferences.setString(kName, value ?? '');
  String? get name => preferences.getString(kName);
  set email(String? value) => preferences.setString(kEmail, value ?? '');
  String? get email => preferences.getString(kEmail);

  set userID(int? value) => preferences.setInt(kUserID, value ?? 0);
  int? get userID => preferences.getInt(kUserID);
}
