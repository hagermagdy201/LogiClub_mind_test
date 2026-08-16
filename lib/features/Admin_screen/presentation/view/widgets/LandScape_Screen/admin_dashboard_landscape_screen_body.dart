import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/Add_question_scren/presentation/question_screen.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/snackbar.dart';
import 'package:logiclub/features/question_bank_screen/presentation/question_bank_screen.dart';
import 'package:logiclub/features/question_bank_screen/presentation/widgets/LandScape_Screen/question_bank_screen_body_landscape.dart';

class AdminDashboardScreenBodyLandscape extends StatefulWidget {
  const AdminDashboardScreenBodyLandscape({super.key});

  @override
  State<AdminDashboardScreenBodyLandscape> createState() =>
      _AdminDashboardScreenBodyState();
}

class _AdminDashboardScreenBodyState
    extends State<AdminDashboardScreenBodyLandscape> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('questions_category')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No categories found '-'",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                      color: color.fontcolor,
                    ),
                  ),
                );
              }

              final docs = snapshot.data!.docs;
              final categoryCount = docs.length;

              return ListView.builder(
                itemCount: categoryCount,
                itemBuilder: (context, index) {
                  final categoryId = docs[index].id;
                  final categoryData =
                      docs[index].data() as Map<String, dynamic>;
                  final categoryName = categoryData['name'] ?? '';

                  return Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 5.w,
                      horizontal: 10.w,
                    ),
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                      color: color.blackColor,
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: ListTile(
                      title: Text(
                        categoryName,
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: color.fontcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('questions_category')
                            .doc(categoryId)
                            .collection('questions')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Text("Loading...");
                          }
                          final count = snapshot.data!.docs.length;
                          return Text(
                            "Num of Questions: $count",
                            style: TextStyle(
                              fontSize: 6.sp,
                              color: color.fontcolor,
                            ),
                          );
                        },
                      ),
                      trailing: PopupMenuButton<int>(
                        icon: Icon(Icons.more_vert, color: color.fontcolor),
                        color: Colors.white,
                        iconSize: 10.sp,
                        onSelected: (value) async {
                          switch (value) {
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return QuestionScreen(
                                      categoryName: categoryName,
                                    );
                                  },
                                ),
                              );
                              break;
                            case 2:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuestionBank(
                                    categoryId: categoryId,
                                    categoryName: categoryName,
                                  ),
                                ),
                              );
                              break;
                            case 3:
                              await FirebaseFirestore.instance
                                  .collection('questions_category')
                                  .doc(categoryId)
                                  .delete();

                              SnackbarScreen.showSuccess(
                                "Deleted",
                                "Category Deleted successfully",
                                color.primary,
                              );
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            value: 1,
                            child: Text(
                              'Add Question',
                              style: TextStyle(
                                color: color.blackColor,
                                fontSize: 6.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 2,
                            child: Text(
                              'Question Bank',
                              style: TextStyle(
                                color: color.blackColor,
                                fontSize: 6.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 3,
                            child: Text(
                              'Delete Quiz',
                              style: TextStyle(
                                color: color.blackColor,
                                fontSize: 6.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
