import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indian_app_guy/core/themes/app_styles.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.error,
    required this.onRetry,
    required this.onCancel,
  });

  final String error;
  final Function() onRetry;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.red, size: 50),
          SizedBox(height: 10.h),
          Text(error, style: AppStyles.ts16W500cGrey600),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: onRetry,
            child: Text('Retry', style: AppStyles.ts14W500cBlack),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: onCancel,
            child: Text('Cancel', style: AppStyles.ts14W500cBlack),
          ),
        ],
      ),
    );
  }
}
