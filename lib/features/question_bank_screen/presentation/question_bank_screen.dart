import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/question_bank_screen/presentation/widgets/LandScape_Screen/question_bank_screen_body_landscape.dart';

class QuestionBank extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const QuestionBank({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20.sp,
        iconTheme: IconThemeData(color: color.fontcolor, size: 8.sp),
        backgroundColor: color.blackColor,
        title: Text(
          "Question Bank: $categoryName",
          style: TextStyle(
            fontSize: 8.sp,
            color: color.fontcolor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.blackbackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: QuestionBankScreen(categoryId: categoryId),
      ),
    );
  }
}
