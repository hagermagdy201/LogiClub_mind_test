import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/snackbar.dart';

class QuestionBankScreen extends StatelessWidget {
  final String categoryId;

  const QuestionBankScreen({super.key, required this.categoryId});

  Future<void> _showDeleteDialog(
    BuildContext context,
    String questionId,
    String questionText,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: color.blackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: Text(
            'Confirm Deletion',
            style: TextStyle(
              color: color.fontcolor,
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this question? \n"$questionText"',
            style: TextStyle(color: color.fontcolor, fontSize: 8.sp),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey, fontSize: 6.sp),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                Navigator.of(dialogContext).pop();

                try {
                  await FirebaseFirestore.instance
                      .collection('questions_category')
                      .doc(categoryId)
                      .collection('questions')
                      .doc(questionId)
                      .delete();

                  SnackbarScreen.showSuccess(
                    "Deletion Successful",
                    "The question has been deleted successfully.",
                    color.primary,
                  );
                } catch (e) {
                  SnackbarScreen.showSuccess(
                    "Error",
                    "Failed to delete question: $e",
                    Colors.red,
                  );
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white, fontSize: 7.sp),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('questions_category')
          .doc(categoryId)
          .collection('questions')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No questions available in this category.",
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.bold,
                color: color.fontcolor,
              ),
            ),
          );
        }

        final questionsDocs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: questionsDocs.length,
          padding: EdgeInsets.all(16.w),
          itemBuilder: (context, index) {
            final qDoc = questionsDocs[index];
            final qData = qDoc.data() as Map<String, dynamic>;
            final questionText =
                qData['question'] ?? qData['title'] ?? 'No title';

            return Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: color.blackColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: ListTile(
                title: Text(
                  "${index + 1}. $questionText",
                  style: TextStyle(
                    color: color.fontcolor,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _showDeleteDialog(context, qDoc.id, questionText);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
