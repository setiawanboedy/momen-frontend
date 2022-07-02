import 'package:shared_preferences/shared_preferences.dart';

class TransPrefManager {
  String kUserID = 'userID';

  SharedPreferences preferences;
  TransPrefManager(this.preferences);

  set userID(int? value) => preferences.setInt(kUserID, value ?? 0);
  int? get userID => preferences.getInt(kUserID);
}
