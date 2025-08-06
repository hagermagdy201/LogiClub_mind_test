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
        backgroundColor: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // شكل الزر
        ),
        padding: EdgeInsets.all(20.sp),
        minimumSize: Size(150.w, 60.h),
        maximumSize: Size(250.w, 90.h), // حجم الزر
      ),
      child: Text(
        'Let’s Go',
        style: TextStyle(
          fontSize: 25.sp,
          color: color.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
