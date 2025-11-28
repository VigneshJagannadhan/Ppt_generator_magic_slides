import 'package:flutter/material.dart';
import 'package:indian_app_guy/features/Auth/presentation/screens/auth_screen.dart';
import 'package:indian_app_guy/features/Home/presentation/screens/create_ppt_screen.dart';
import 'package:indian_app_guy/features/Home/presentation/screens/display_ppt_screen.dart';
import 'package:indian_app_guy/features/Home/presentation/screens/home_screen.dart';
import 'package:indian_app_guy/features/Settings/presentation/screens/set_access_id_screen.dart';
import 'package:indian_app_guy/features/Settings/presentation/screens/settings_screen.dart';
import 'package:indian_app_guy/features/Splash/presentation/screens/splash_screen.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
  SplashScreen.route: (context) => SplashScreen(),
  AuthScreen.route: (context) => AuthScreen(),
  HomeScreen.route: (context) => HomeScreen(),
  CreatePPTScreen.route: (context) => CreatePPTScreen(),
  SettingsScreen.route: (context) => SettingsScreen(),
  DisplayPptScreen.route: (context) => DisplayPptScreen(),
  SetAccessIdScreen.route: (context) => SetAccessIdScreen(),
};
