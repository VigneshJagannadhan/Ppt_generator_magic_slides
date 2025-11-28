import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indian_app_guy/core/constants/app_constants.dart';
import 'package:indian_app_guy/core/helpers/navigation_helper.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 70.w,
      leading: GestureDetector(
        onTap: () => NavigationHelper.pop(context: context),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: SvgPicture.asset(AppConstants.backIconSvg),
        ),
      ),
      title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
    );
  }

  @override
  Size get preferredSize => Size(1.sw, 70.h);
}
