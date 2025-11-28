import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/core/themes/app_colors.dart';
import 'package:indian_app_guy/core/themes/app_styles.dart';

class CustomPPTItem extends StatelessWidget {
  const CustomPPTItem({
    super.key,
    required this.url,
    required this.title,
    required this.date,
  });

  final String title;
  final String url;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200.h,
          width: 1.sw,
          margin: EdgeInsets.only(bottom: 10.h, right: 20.w, left: 20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: AssetImage(url)),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        Container(
          height: 200.h,
          width: 1.sw,
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.transparent, AppColors.secondaryColor],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppStyles.ts20W400cWhite),
              Text(date, style: AppStyles.ts14W500cWhite),
            ],
          ),
        ),
      ],
    );
  }
}
