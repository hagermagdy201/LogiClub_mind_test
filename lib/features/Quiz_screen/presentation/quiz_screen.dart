import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/features/Quiz_screen/presentation/widgets/quiz_screen_body.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;

class QuizScreen extends StatelessWidget {
  final String categoryName;
  const QuizScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Quiz',
          style: TextStyle(
            color: color.whiteColor,
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: QuizScreenBody(categoryName: categoryName),
    );
  }
}
