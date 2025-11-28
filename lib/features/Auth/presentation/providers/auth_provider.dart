import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:indian_app_guy/shared/providers/base_provider.dart';
import 'package:indian_app_guy/core/exceptions/failure.dart';
import 'package:indian_app_guy/core/helpers/navigation_helper.dart';
import 'package:indian_app_guy/core/services/storage_service.dart';
import 'package:indian_app_guy/core/services/supabase_service.dart';
import 'package:indian_app_guy/features/Home/presentation/screens/home_screen.dart';
import 'package:indian_app_guy/features/Splash/presentation/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends BaseProvider {
  SupabaseService supabaseService;
  StorageService storageService;
  AuthProvider({required this.supabaseService, required this.storageService});

  @override
  reset() {
    _isLogin = true;
    setLoading(false);
  }

  bool _isLogin = true;
  bool get isLogin => _isLogin;
  toggleLoginMode() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    setError(null);
    Either<Failure, AuthResponse> authResponse = await supabaseService.signIn(
      email: email,
      password: password,
    );

    authResponse.fold(
      (error) => setError(error),
      (response) async => await saveSessionDataToLocalStorage(
        response: response,
        context: context,
      ),
    );
  }

  register({
    required String email,
    required String password,
    required Map<String, dynamic> data,
    required BuildContext context,
  }) async {
    setError(null);
    Either<Failure, AuthResponse> authResponse = await supabaseService.signUp(
      data: data,
      email: email,
      password: password,
    );

    authResponse.fold(
      (error) => setError(error),
      (response) async => await saveSessionDataToLocalStorage(
        response: response,
        context: context,
      ),
    );
  }

  logout(context) async {
    setLoading(true);
    await supabaseService.signOut();
    await storageService.clearAll();
    NavigationHelper.pushReplacementNamed(
      context: context,
      route: SplashScreen.route,
    );
    reset();
  }

  Future<void> saveSessionDataToLocalStorage({
    required AuthResponse response,
    required BuildContext context,
  }) async {
    await storageService.saveAccessToken(
      token: response.session?.accessToken ?? "",
    );
    await storageService.saveRefreshToken(
      token: response.session?.refreshToken ?? "",
    );
    await storageService.saveUserId(id: response.session?.user.id ?? "");

    await storageService.saveUserEmail(
      email: response.session?.user.email ?? "",
    );

    if (!context.mounted) return;
    NavigationHelper.pushReplacementNamed(
      context: context,
      route: HomeScreen.route,
    );
  }
}
