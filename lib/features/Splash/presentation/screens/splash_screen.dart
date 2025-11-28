import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indian_app_guy/shared/providers/theme_provider.dart';
import 'package:indian_app_guy/core/DI/locator.dart';
import 'package:indian_app_guy/core/helpers/navigation_helper.dart';
import 'package:indian_app_guy/core/services/storage_service.dart';
import 'package:indian_app_guy/features/Auth/presentation/screens/auth_screen.dart';
import 'package:indian_app_guy/features/Home/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  void _initAsync() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var storageService = locator<StorageService>();

      bool isDarkMode = storageService.getDarkMode() ?? true;
      if (!mounted) return;
      context.read<ThemeProvider>().setDarkTheme(isDarkMode);

      /// ADDING A DELAY JUST TO DISPLAY THE SPLASH UI FOR 2 SECONDS
      await Future.delayed(Duration(seconds: 2));

      var token = await storageService.fetchAccessToken();
      if (token != null) {
        if (!mounted) return;
        NavigationHelper.pushReplacementNamed(
          context: context,
          route: HomeScreen.route,
        );
      } else {
        if (!mounted) return;
        NavigationHelper.pushReplacementNamed(
          context: context,
          route: AuthScreen.route,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Indian App Guy',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 20),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
