import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:indian_app_guy/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static SharedPreferences? _sharedPreferences;

  /// INITIALIZE STORAGE SERVICE
  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  clearAll() async {
    await _sharedPreferences?.clear();
    await _secureStorage.deleteAll();
  }

  /// -------------------------- ACCESS TOKEN ----------------------------- ///
  saveAccessToken({required String token}) async {
    await _secureStorage.write(key: AppConstants.spAccessToken, value: token);
  }

  Future<String?> fetchAccessToken() async {
    return await _secureStorage.read(key: AppConstants.spAccessToken);
  }

  clearAccessToken() async {
    await _secureStorage.delete(key: AppConstants.spAccessToken);
  }

  /// -------------------------- REFRESH TOKEN ----------------------------- ///
  saveRefreshToken({required String token}) async {
    await _secureStorage.write(key: AppConstants.spRefreshToken, value: token);
  }

  Future<String?> fetchRefreshToken() async {
    return await _secureStorage.read(key: AppConstants.spRefreshToken);
  }

  clearRefreshToken() async {
    await _secureStorage.delete(key: AppConstants.spRefreshToken);
  }

  /// -------------------------- USER ID ----------------------------- ///
  saveUserId({required String id}) async {
    await _sharedPreferences?.setString(AppConstants.spUserId, id);
  }

  fetchUserId() async {
    return _sharedPreferences?.getString(AppConstants.spUserId);
  }

  clearUserId() async {
    await _sharedPreferences?.remove(AppConstants.spUserId);
  }

  /// -------------------------- USER EMAIL ----------------------------- ///
  saveUserEmail({required String email}) async {
    await _sharedPreferences?.setString(AppConstants.spUserEmail, email);
  }

  fetchUserEmail() async {
    return _sharedPreferences?.getString(AppConstants.spUserEmail);
  }

  clearUserEmail() async {
    await _sharedPreferences?.remove(AppConstants.spUserEmail);
  }

  /// -------------------------- THEME MODE ----------------------------- ///
  setDarkMode({required bool value}) async {
    await _sharedPreferences?.setBool(AppConstants.spDarkMode, value);
  }

  getDarkMode() {
    return _sharedPreferences?.getBool(AppConstants.spDarkMode);
  }

  clearDarkMode() async {
    await _sharedPreferences?.remove(AppConstants.spDarkMode);
  }
}
