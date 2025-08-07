import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;

class BtnView extends StatelessWidget {
  const BtnView({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Respond to button press
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color.whiteColor, // لون الخلفية الشفاف
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: color.secondary, // لون الحدود
            width: 2.sp, // سمك الحدود
          ),
          borderRadius: BorderRadius.circular(10.sp), // شكل الزر
        ),
        padding: EdgeInsets.all(10.sp),
        minimumSize: Size(120.w, 30.h),
        maximumSize: Size(400.w, 90.h),
      ),
      child: Text(
        'Let’s Go',
        style: TextStyle(
          fontSize: 18.sp,
          color: color.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
