import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/core/helpers/navigation_helper.dart';
import 'package:indian_app_guy/features/Settings/presentation/screens/set_access_id_screen.dart';
import 'package:indian_app_guy/shared/popups/general_popup_buttons.dart';
import 'package:indian_app_guy/shared/providers/theme_provider.dart';
import 'package:indian_app_guy/core/DI/locator.dart';
import 'package:indian_app_guy/core/services/storage_service.dart';
import 'package:indian_app_guy/features/Auth/presentation/providers/auth_provider.dart';
import 'package:indian_app_guy/features/Auth/presentation/widgets/primary_elevated_button.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_appbar.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_switch_with_label.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static const String route = 'settingsScreen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Settings'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryElevatedButton(
              label: 'Set Access ID',
              onTap:
                  () => NavigationHelper.pushNamed(
                    context: context,
                    route: SetAccessIdScreen.route,
                  ),
            ),
            SizedBox(height: 10.h),
            Consumer<ThemeProvider>(
              builder: (context, theme, _) {
                return CustomSwitchWithLabel(
                  label: 'Dark Mode',
                  value: theme.themeMode == ThemeMode.dark,
                  onChanged: (value) => _setTheme(value, theme),
                );
              },
            ),

            SizedBox(height: 10.h),
            Consumer<AuthProvider>(
              builder: (context, auth, _) {
                return PrimaryElevatedButton(
                  color: Colors.red,
                  label: 'Sign out',
                  isLoading: auth.isLoading,
                  onTap: () => _logout(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setTheme(bool value, ThemeProvider theme) {
    var storage = locator<StorageService>();
    storage.setDarkMode(value: value);
    if (value) {
      theme.themeMode = ThemeMode.dark;
    } else {
      theme.themeMode = ThemeMode.light;
    }
  }

  _logout(BuildContext context) async {
    var result = await showPopupWithButtons(
      context: context,
      header: 'Sign Out',
      message: 'Are you sure you want to sign out?',
      button1Text: 'No, Stay',
      button2Text: 'Yes, Signout',
      onButton1Pressed: () {
        Navigator.pop(context, false);
      },
      onButton2Pressed: () async {
        Navigator.pop(context, true);
      },
    );

    if (result ?? false) {
      if (!context.mounted) return;
      AuthProvider auth = context.read<AuthProvider>();
      await auth.logout(context);
    }
  }
}
