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
        toolbarHeight: 100,
        iconTheme: IconThemeData(
          color: color.whiteColor,
          size: 16.sp,
          weight: 900,
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
