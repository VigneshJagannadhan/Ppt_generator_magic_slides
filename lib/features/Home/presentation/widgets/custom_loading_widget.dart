import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/core/constants/app_constants.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key, this.text, this.lottie});
  final String? text;
  final String? lottie;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (text != null && text?.trim() != "") Text(text!),
          if (text != null && text?.trim() != "") SizedBox(height: 20.h),
          Lottie.asset(lottie ?? AppConstants.loadingLottie),
        ],
      ),
    );
  }
}
