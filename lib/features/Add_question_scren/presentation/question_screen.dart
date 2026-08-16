import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/Add_question_scren/presentation/widgets/LandScape_Screen/question_screen_body_landscape.dart';
import 'package:logiclub/features/Add_question_scren/presentation/widgets/Portrait_screen/question_screen_body_portrait.dart';

class QuestionScreen extends StatefulWidget {
  final dynamic categoryName;

  const QuestionScreen({super.key, required this.categoryName});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    final devicemediaorientation = MediaQuery.of(context).orientation;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 20.sp,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: devicemediaorientation == Orientation.portrait ? 15.sp : 10.sp,
        ),
        backgroundColor: color.blackColor,
        title: Text(
          'AddQuestion',
          style: TextStyle(
            fontSize: devicemediaorientation == Orientation.portrait
                ? 15.sp
                : 10.sp,
            color: color.fontcolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.blackbackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: devicemediaorientation == Orientation.portrait
            ? QuestionScreenBodyPortrait(
                categoryName: super.widget.categoryName,
              )
            : QuestionScreenBodyLandscape(
                categoryName: super.widget.categoryName,
              ),
      ),
    );
  }
}
