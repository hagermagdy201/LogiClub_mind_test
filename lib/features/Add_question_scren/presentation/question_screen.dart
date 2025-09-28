import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Add_question_scren/presentation/widgets/question_screen_body.dart';

class QuestionScreen extends StatefulWidget {
  final dynamic categoryName;

  const QuestionScreen({super.key, required this.categoryName});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: color.blackColor,
        title: Text(
          'AddQuestion',
          style: TextStyle(
            fontSize: 30.sp,
            color: color.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsPaths.blackbackgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child: QuestionScreenBody(categoryName: super.widget.categoryName),
        ),
      ),
    );
  }
}
