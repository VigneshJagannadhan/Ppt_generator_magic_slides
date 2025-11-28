import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/core/themes/app_styles.dart';

class PrimaryElevatedButton extends StatelessWidget {
  const PrimaryElevatedButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
    this.isLoading = false,
  });

  final String label;
  final Function() onTap;
  final Color? color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          backgroundColor: color,
        ),
        child:
            isLoading
                ? CupertinoActivityIndicator()
                : Text(label, style: AppStyles.ts16WBoldcWhite),
      ),
    );
  }
}
