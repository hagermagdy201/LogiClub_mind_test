import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String numofQue;
  final Color bgColor;
  final int? position; // Optional position parameter

  const CategoryCard({
    super.key,
    required this.title,
    required this.numofQue,
    required this.bgColor,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.w),
      ),
      padding: EdgeInsets.all(7.w),
      margin: EdgeInsets.all(8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: position == 0 ? 20.sp : 12.sp,
                    fontFamily: "Chewy",
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "$numofQue Questions",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: position == 0 ? 16.sp : 12.sp,
                    color: Colors.white70,
                    fontFamily: "Chewy",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
