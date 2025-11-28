import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/core/helpers/navigation_helper.dart';
import 'package:indian_app_guy/core/themes/app_colors.dart';
import 'package:indian_app_guy/features/Auth/presentation/widgets/primary_elevated_button.dart';

showPopupWithButtons({
  required BuildContext context,
  required String header,
  required String message,
  required String button1Text,
  required String button2Text,
  Function()? onButton1Pressed,
  required Function() onButton2Pressed,
}) async {
  return await showDialog(
    barrierDismissible: true,
    context: context,
    builder:
        (context) => Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Header',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Body with a large text for confirmation or other purposes',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 20.h),

                PrimaryElevatedButton(
                  color: AppColors.cGrey600,
                  label: button1Text,
                  onTap:
                      onButton1Pressed ??
                      () => NavigationHelper.pop(context: context),
                ),
                SizedBox(height: 10.h),

                PrimaryElevatedButton(
                  color: AppColors.primaryColor,
                  label: button2Text,
                  onTap: onButton2Pressed,
                ),
              ],
            ),
          ),
        ),
  );
}
