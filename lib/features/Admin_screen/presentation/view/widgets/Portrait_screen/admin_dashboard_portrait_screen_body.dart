import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Add_question_scren/presentation/question_screen.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/snackbar.dart';

class AdminDashboardScreenBodyPortrait extends StatefulWidget {
  const AdminDashboardScreenBodyPortrait({super.key});

  @override
  State<AdminDashboardScreenBodyPortrait> createState() =>
      _AdminDashboardScreenBodyState();
}

class _AdminDashboardScreenBodyState
    extends State<AdminDashboardScreenBodyPortrait> {
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
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No categories found  '-'",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                      color: color.whiteColor,
                    ),
                  ),
                );
              }

              final docs = snapshot.data!.docs;
              final categoryCount = snapshot.data!.docs.length;

              return ListView.builder(
                itemCount: categoryCount,
                itemBuilder: (context, index) {
                  final categoryId = docs[index].id;
                  return Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10.w,
                      horizontal: 10.w,
                    ),
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: ListTile(
                      title: Text(
                        docs[index]['name'],
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
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
                          if (!snapshot.hasData) return Text("Loading...");
                          final count = snapshot.data!.docs.length;
                          return Text(
                            "Num of Questions: $count",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white70,
                            ),
                          );
                        },
                      ),
                      trailing: PopupMenuButton<int>(
                        icon: Icon(Icons.more_vert, color: color.whiteColor),
                        color: color.whiteColor,
                        iconSize: 15.sp,
                        onSelected: (value) async {
                          switch (value) {
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return QuestionScreen(
                                      categoryName: docs[index]['name'],
                                    );
                                  },
                                ),
                              );
                              break;
                            case 2:
                              // Navigate to Question Bank Screen
                              break;
                            case 3:
                              await FirebaseFirestore.instance
                                  .collection('questions_category')
                                  .doc(docs[index]['name'])
                                  .delete();

                              SnackbarScreen.showSuccess(
                                "Deleted",
                                "Category Deleted successfully",
                                color.greenColor,
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
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 2,
                            child: Text(
                              'Question Bank',
                              style: TextStyle(
                                color: color.blackColor,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          PopupMenuItem<int>(
                            value: 3,
                            child: Text(
                              'Delete Quiz',
                              style: TextStyle(
                                color: color.blackColor,
                                fontSize: 10.sp,
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
