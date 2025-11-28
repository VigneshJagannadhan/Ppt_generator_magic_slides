import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showGeneralSnackbar({
  required BuildContext context,
  required String errorMessage,
}) => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
    content: Row(
      children: [
        Icon(Icons.error, color: Colors.red),
        SizedBox(width: 10.w),
        Expanded(child: Text(errorMessage)),
      ],
    ),
  ),
);
