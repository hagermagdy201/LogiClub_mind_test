import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FruitCard extends StatelessWidget {
  final String title;
  final String numofQue;
  final Color bgColor;
  const FruitCard({
    Key? key,
    required this.title,
    required this.numofQue,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.w),
      ),
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                  fontFamily: "Chewy",
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "$numofQue Questions",
                style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.white70,
                  fontFamily: "Chewy",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
