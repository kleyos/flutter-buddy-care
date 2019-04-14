import 'dart:convert';
import 'package:buddy_care/models/account-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service provides you instance if SharedPreferences, so you can access it synchronously
class PrefsService {
  static PrefsService _instance;
  static const accountStoreKey = 'account';

  PrefsService.init(this._prefs) {
    _instance = this;
  }

  factory PrefsService() {
    return _instance;
  }

  final SharedPreferences _prefs;

  Future<bool> storeByKey(String key, String data) async {
    return _prefs.setString(key, data);
  }

  Future<void> clearSharedPreferences() async {
    return await _prefs.clear();
  }

  Future<Account> restoreSession() async {
    String data = _prefs.getString(accountStoreKey);
    return data != null ? Account.fromJson(json.decode(data)) : null;
  }

  Future<bool> storeSession(Account a) async =>
    storeByKey(accountStoreKey, json.encode(a.toJson()));

  Future<bool> deleteSession() async {
    return _prefs.remove(accountStoreKey);
  }
}
