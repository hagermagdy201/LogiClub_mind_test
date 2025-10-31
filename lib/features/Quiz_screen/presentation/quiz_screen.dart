import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/features/Quiz_screen/presentation/widgets/LandScape_Screen/quiz_screen_body_landscape.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Quiz_screen/presentation/widgets/Portrait_screen/quiz_screen_body_portrtait.dart';

class QuizScreen extends StatelessWidget {
  final String categoryName;
  const QuizScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final devicemediaorientation = MediaQuery.of(context).orientation;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.white, size: 18.sp),
        title: Text(
          "Quiz",
          style: TextStyle(
            color: color.whiteColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Chewy",
          ),
          // maxLines: 4,sr
          // overflow: TextOverflow.visible, // عشان ما يقطعش النص
          // textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // centerTitle: true,
      ),
      body: devicemediaorientation == Orientation.portrait
          ? QuizScreenBodyPortrtait(categoryName: categoryName)
          : QuizScreenBodyLandscape(categoryName: categoryName),
    );
  }
}
