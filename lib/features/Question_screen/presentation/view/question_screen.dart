import 'package:flutter/material.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/features/Question_screen/presentation/view/widgets/question_screen_body.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.whitebackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: QuestionScreenBody(),
      ),
    );
  }
}
