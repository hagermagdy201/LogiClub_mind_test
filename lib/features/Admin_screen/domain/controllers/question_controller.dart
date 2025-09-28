import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/snackbar.dart';

class QuestionController extends GetxController {
  TextEditingController questionCategoryController = TextEditingController();

  void saveQuestionCategorytoFirebase() async {
    String category = questionCategoryController.text.trim();

    print(
      "questionCategoryController.text------------------------------------: ${questionCategoryController.text}",
    );
    if (category.isNotEmpty) {
      try {
        FirebaseFirestore.instance
            .collection("questions_category")
            .doc(category)
            .set({"name": category});
        SnackbarScreen.showSuccess(
          'Success',
          'Category saved successfully',
          color.greenColor,
        );
        questionCategoryController.clear();
      } catch (e) {
        print('Error saving category: $e');
        Get.snackbar('Error', 'Failed to save category');
      }
    } else {
      SnackbarScreen.showSuccess('failed', 'Category is empty', color.redColor);
    }
  }
}
