import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TxtView extends StatelessWidget {
  const TxtView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: Text(
        'Let’s test your brain power! Ready?',
        style: TextStyle(
          fontSize: 40.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "Chewy",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
