import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/core/DI/locator.dart';
import 'package:indian_app_guy/core/services/storage_service.dart';
import 'package:indian_app_guy/core/themes/app_colors.dart';
import 'package:indian_app_guy/core/themes/app_styles.dart';
import 'package:indian_app_guy/core/helpers/navigation_helper.dart';
import 'package:indian_app_guy/features/Home/presentation/screens/create_ppt_screen.dart';
import 'package:indian_app_guy/features/Home/presentation/widgets/custom_ppt_item.dart';
import 'package:indian_app_guy/features/Settings/presentation/screens/settings_screen.dart';
import 'package:indian_app_guy/shared/snackbars/general_snackbar.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 20.w),
        title: Text('MagicSlides'),
        actions: [
          GestureDetector(
            onTap:
                () => NavigationHelper.pushNamed(
                  context: context,
                  route: SettingsScreen.route,
                ),
            child: CircleAvatar(
              backgroundColor: AppColors.secondaryColor,
              child: Icon(Icons.settings, color: AppColors.cWhite),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder:
                  (context, index) => CustomPPTItem(
                    title: 'PPT Name $index',
                    url: 'assets/images/ppt-${index + 1}.png',
                    date: 'Created on 27 Nov 06:44PM',
                  ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Create a new PPT', style: AppStyles.ts14W500cBlack),
        onPressed: () async {
          var storageService = locator<StorageService>();
          var accessid = await storageService.fetchAccessId();
          if (accessid == null) {
            if (!context.mounted) return;
            showGeneralSnackbar(
              context: context,
              errorMessage:
                  'Please add your access Id from the settings to continue',
            );
            return;
          }

          if (!context.mounted) return;
          NavigationHelper.pushNamed(
            context: context,
            route: CreatePPTScreen.route,
          );
        },
      ),
    );
  }
}
