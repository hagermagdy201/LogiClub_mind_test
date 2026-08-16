import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/view_category_screen/presentation/view/view_category_screen.dart';

class BtnView extends StatelessWidget {
  final int minsize;
  final int maxsize;
  final int fontsize;
  final int paddingsize;
  const BtnView({
    super.key,
    required this.minsize,
    required this.maxsize,
    required this.fontsize,
    required this.paddingsize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ViewCategoryScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color.secondary, width: 2.sp),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        padding: EdgeInsets.all(paddingsize.sp),
        minimumSize: Size(minsize.w, 20.h),
        maximumSize: Size(maxsize.w, 90.h),
      ),
      child: Text(
        'Let’s Go',
        style: TextStyle(
          fontSize: fontsize.sp,
          color: color.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
