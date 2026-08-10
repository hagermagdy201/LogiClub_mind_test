import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;

class AppDialog {
  static void showSuccess(
    BuildContext context,
    String message,
    Color mainColor,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        // title: Text(
        //   title,
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     color: mainColor,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 12.sp,
        //   ),
        // ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.sp),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: mainColor),
            onPressed: () => Navigator.of(context).pop(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Text(
                "OK",
                style: TextStyle(color: color.whiteColor, fontSize: 10.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
