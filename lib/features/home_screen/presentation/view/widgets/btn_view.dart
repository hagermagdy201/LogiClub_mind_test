import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Question_screen/presentation/view/question_screen.dart';

class BtnView extends StatelessWidget {
  const BtnView({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QuestionScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color.whiteColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color.secondary, width: 2.sp),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        padding: EdgeInsets.all(10.sp),
        minimumSize: Size(200.w, 50.h),
        maximumSize: Size(400.w, 90.h),
      ),
      child: Text(
        'Let’s Go',
        style: TextStyle(
          fontSize: 22.sp,
          color: color.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
