import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String numofQue;
  final Color bgColor;

  const CategoryCard({
    super.key,
    required this.title,
    required this.numofQue,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.w),
      ),
      padding: EdgeInsets.all(5.w),
      margin: EdgeInsets.all(16.w),
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
                    fontSize: 18.sp,
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
                    fontSize: 15.sp,
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
