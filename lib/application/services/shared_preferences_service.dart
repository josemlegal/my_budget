import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferenceApi {
  Future<void> init();
  bool getFirstTimeOpen();
  Future<void> setFirstTimeOpen({required bool val});
  bool getFreeReminderShown();
  Future<void> setFreeReminderShow({required bool val});
  bool getTermsAccepted();
  Future<void> setTermsAccepted({required bool val});
  String? getTermsUpdateDate();
  Future<void> setTermsUpdateDate({required DateTime val});
  String? getNotificationToken();
  Future<void> setNotificationToken({required String token});
  bool getWeightNotificationHasBeenSent();
  Future<void> setWeightNotification({required bool val});
  bool getProteinNotificationHasBeenSent();
  Future<void> setProteinNotification({required bool val});
  bool getFiberNotificationHasBeenSent();
  Future<void> setFiberNotification({required bool val});
  String? getAppleRefreshToken();
  Future<void> setAppleRefreshToken(String appleToken);
  Future<void> setUTMValues(Map<String, String?> utmValues);
  Map<String, dynamic> getUTMValues();
  Future<SharedPreferences> getInstance();
  Future<void> setUserName({required String userName});
  String? getUserName();
  bool showHomeOnboarding();
  Future<void> setShowHomeOnboarding({required bool val});
  bool showSearchOnboarding();
  Future<void> setShowSearchOnboarding({required bool val});
}

class SharedPreferencesService implements SharedPreferenceApi {
  SharedPreferences? _preferences;

  SharedPreferencesService({SharedPreferences? preferences})
      : _preferences = preferences;

  @override
  Future<void> init() async {
    _preferences ??= await getInstance();
  }

  @override
  bool getFreeReminderShown() {
    return _preferences!.getBool('freeReminderShown') ?? false;
  }

  @override
  Future<void> setFreeReminderShow({required bool val}) async {
    await _preferences!.setBool('freeReminderShown', val);
  }

  @override
  String? getNotificationToken() {
    return _preferences!.getString('notificationToken');
  }

  @override
  Future<void> setNotificationToken({required String token}) async {
    await _preferences!.setString("notificationToken", token);
  }

  @override
  bool getFirstTimeOpen() {
    return _preferences!.getBool('firstTimeOpen') ?? true;
  }

  @override
  Future<void> setFirstTimeOpen({required bool val}) async {
    await _preferences!.setBool('firstTimeOpen', val);
  }

  @override
  bool getTermsAccepted() {
    return _preferences!.getBool('termsAccepted') ?? false;
  }

  @override
  Future<void> setTermsAccepted({required bool val}) async {
    await _preferences!.setBool('termsAccepted', val);
  }

  @override
  String? getTermsUpdateDate() {
    return _preferences!.getString('termsUpdateDate');
  }

  @override
  Future<void> setTermsUpdateDate({required DateTime val}) async {
    await _preferences!.setString('termsUpdateDate', val.toString());
  }

  @override
  bool getFiberNotificationHasBeenSent() {
    return _preferences!.getBool('fiberNotif') ?? false;
  }

  @override
  bool getProteinNotificationHasBeenSent() {
    return _preferences!.getBool('proteinNotif') ?? false;
  }

  @override
  bool getWeightNotificationHasBeenSent() {
    return _preferences!.getBool('weightNotif') ?? false;
  }

  @override
  Future<void> setFiberNotification({required bool val}) async {
    await _preferences!.setBool('fiberNotif', val);
  }

  @override
  Future<void> setProteinNotification({required bool val}) async {
    await _preferences!.setBool('proteinNotif', val);
  }

  @override
  Future<void> setWeightNotification({required bool val}) async {
    await _preferences!.setBool('weightNotif', val);
  }

  @override
  Map<String, dynamic> getUTMValues() {
    return Map<String, dynamic>.from(
        json.decode(_preferences!.getString('utmValues') ?? '{}'));
  }

  @override
  Future<void> setUTMValues(Map<String, String?> utmValues) async {
    await _preferences!.setString('utmValues', json.encode(utmValues));
  }

  @override
  String? getAppleRefreshToken() {
    return _preferences!.getString('appleRefreshToken');
  }

  @override
  Future<void> setAppleRefreshToken(String appleToken) async {
    await _preferences!.setString('appleRefreshToken', appleToken);
  }

  @override
  Future<SharedPreferences> getInstance() async =>
      await SharedPreferences.getInstance();

  @override
  String? getUserName() {
    return _preferences!.getString('userName');
  }

  @override
  Future<void> setUserName({required String userName}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }

  @override
  Future<void> setShowHomeOnboarding({required bool val}) async {
    await _preferences!.setBool('showHomeOnboarding', val);
  }

  @override
  bool showHomeOnboarding() {
    return _preferences!.getBool('showHomeOnboarding') ?? true;
  }

  @override
  Future<void> setShowSearchOnboarding({required bool val}) async {
    await _preferences!.setBool('showSearchOnboarding', val);
  }

  @override
  bool showSearchOnboarding() {
    return _preferences!.getBool('showSearchOnboarding') ?? true;
  }
}
