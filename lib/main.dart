import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/shared/providers/theme_provider.dart';
import 'package:indian_app_guy/core/DI/locator.dart';
import 'package:indian_app_guy/core/DI/app_providers.dart';
import 'package:indian_app_guy/core/routes/app_routes.dart';
import 'package:indian_app_guy/core/services/storage_service.dart';
import 'package:indian_app_guy/core/services/supabase_service.dart';
import 'package:indian_app_guy/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  await initializeApp();
  runApp(const IndianAppGuy());
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await dotenv.load(fileName: '.env');
  await locator<SupabaseService>().initialize();
  await StorageService().init();
}

class IndianAppGuy extends StatelessWidget {
  const IndianAppGuy({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(370, 870),
      ensureScreenSize: true,
      builder: (_, child) => child!,
      child: MultiProvider(
        providers: appProviders,
        child: Consumer<ThemeProvider>(
          builder: (context, theme, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: appThemeLight,
              darkTheme: appThemedark,
              themeMode: theme.themeMode,
              routes: appRoutes,
            );
          },
        ),
      ),
    );
  }
}
