import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/Admin_screen/domain/controllers/question_controller.dart';

class Showdialogbox {
  final QuestionController questionController = Get.put(QuestionController());
  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: SimpleDialog(
            title: Text("Add New Quiz"),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: questionController.questionCategoryController,
                  decoration: InputDecoration(
                    labelText: 'Quiz Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                child: ElevatedButton(
                  onPressed: () {
                    questionController
                        .saveQuestionCategorytoFirebase(); // Save to Firebase
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add Quiz",
                      style: TextStyle(fontSize: 4.sp, color: color.blackColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h), // Add some spacing between button
              Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                child: ElevatedButton(
                  onPressed: () {
                    questionController.questionCategoryController.clear();
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 4.sp, color: color.blackColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
