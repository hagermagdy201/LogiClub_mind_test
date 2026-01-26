import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logiclub/features/Admin_screen/domain/controllers/question_controller.dart';

class Showdialogbox {
  final QuestionController questionController = Get.put(QuestionController());
  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height * 0.1,
          child: SimpleDialog(
            title: Text("Add New Quiz"),
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
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
                  child: Text("Add Quiz"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                child: ElevatedButton(
                  onPressed: () {
                    questionController.questionCategoryController.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
