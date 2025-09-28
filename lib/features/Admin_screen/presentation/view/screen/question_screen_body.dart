import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/custom_text_form_field.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/snackbar.dart';

class QuestionScreenBody extends StatefulWidget {
  final dynamic categoryName;

  const QuestionScreenBody({super.key, required this.categoryName});

  @override
  State<QuestionScreenBody> createState() => _QuestionScreenBodyState();
}

class _QuestionScreenBodyState extends State<QuestionScreenBody> {
  final keyGlobal = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final TextEditingController questionController = TextEditingController();
    final TextEditingController option1Controller = TextEditingController();
    final TextEditingController option2Controller = TextEditingController();
    final TextEditingController option3Controller = TextEditingController();
    final TextEditingController option4Controller = TextEditingController();
    final TextEditingController answerController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(60.0),
      child: Form(
        key: keyGlobal,
        child: Column(
          children: [
            CustomTextFormField(
              controller: questionController,
              label: "Question",
              maxLength: 300,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your question';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              controller: option1Controller,
              label: "option 1",
              maxLength: 20,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter option 1';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              controller: option2Controller,
              label: "option 2",
              maxLength: 20,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter option 2';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              controller: option3Controller,
              label: "option 3",
              maxLength: 20,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter option 3';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              controller: option4Controller,
              label: "option 4",
              maxLength: 100,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter option 4';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              controller: answerController,
              label: "Correct Answer (0 - 3)",
              maxLength: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Correct Answer';
                } else if (int.tryParse(value) == null ||
                    int.parse(value) < 0 ||
                    int.parse(value) > 4) {
                  return 'Please enter a valid number between 0 and 4';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            FilledButton(
              onPressed: () async {
                if (keyGlobal.currentState!.validate()) {
                  await FirebaseFirestore.instance
                      .collection("questions_category")
                      .doc(widget.categoryName.toString())
                      .collection("questions")
                      .add({
                        "question": questionController.text,
                        "option1": option1Controller.text,
                        "option2": option2Controller.text,
                        "option3": option3Controller.text,
                        "option4": option4Controller.text,
                        "correctanswer": int.parse(answerController.text),
                      });
                  keyGlobal.currentState!.reset();
                  SnackbarScreen.showSuccess(
                    "Added",
                    "Question Added successfully",
                    color.greenColor,
                  );
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: color.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                minimumSize: Size(300.h, 60.h),
              ),
              child: Text(
                'Add Question',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
