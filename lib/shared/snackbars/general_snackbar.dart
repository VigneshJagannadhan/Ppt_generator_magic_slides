import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showGeneralSnackbar({
  required BuildContext context,
  required String errorMessage,
  bool isFailure = true,
}) => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
    content: Row(
      children: [
        isFailure
            ? Icon(Icons.error, color: Colors.red)
            : Icon(Icons.check_circle, color: Colors.green),
        SizedBox(width: 10.w),
        Expanded(child: Text(errorMessage)),
      ],
    ),
  ),
);
