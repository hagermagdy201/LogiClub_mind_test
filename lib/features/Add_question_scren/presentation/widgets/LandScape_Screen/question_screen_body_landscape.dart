import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/Add_question_scren/presentation/widgets/LandScape_Screen/app_dialog.dart';
import 'package:logiclub/features/Add_question_scren/presentation/widgets/custom_text_form_field.dart';

class QuestionScreenBodyLandscape extends StatefulWidget {
  final dynamic categoryName;

  const QuestionScreenBodyLandscape({super.key, required this.categoryName});

  @override
  State<QuestionScreenBodyLandscape> createState() =>
      _QuestionScreenBodyState();
}

class _QuestionScreenBodyState extends State<QuestionScreenBodyLandscape> {
  final keyGlobal = GlobalKey<FormState>();
  late TextEditingController questionController;
  late TextEditingController option1Controller;
  late TextEditingController option2Controller;
  late TextEditingController option3Controller;
  late TextEditingController option4Controller;
  late TextEditingController answerController;

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController();
    option1Controller = TextEditingController();
    option2Controller = TextEditingController();
    option3Controller = TextEditingController();
    option4Controller = TextEditingController();
    answerController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: 20.sp,
          left: 16.sp,
          right: 16.sp,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        children: [
          Form(
            key: keyGlobal,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: questionController,
                  label: "Question",
                  maxLength: 150,
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
                  maxLength: 50,
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
                  maxLength: 50,
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
                  maxLength: 50,
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
                  maxLength: 50,
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
                      return 'Please enter a valid number between 0 and 3';
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
                            "correctAnswer": int.parse(answerController.text),
                          });
                      keyGlobal.currentState!.reset();
                      AppDialog.showSuccess(
                        context,

                        "Question Added successfully",
                        color.greenColor,
                      );
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: color.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.sp),
                    ),
                    minimumSize: Size(250.h, 60.h),
                  ),
                  child: Text(
                    'Add Question',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
