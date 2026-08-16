import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/Quiz_screen/presentation/quiz_screen.dart';
import 'package:logiclub/features/view_category_screen/presentation/view/widgets/card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ViewCategoryScreenBody extends StatefulWidget {
  const ViewCategoryScreenBody({super.key});

  @override
  State<ViewCategoryScreenBody> createState() => _ViewCategoryScreenBodyState();
}

class _ViewCategoryScreenBodyState extends State<ViewCategoryScreenBody> {
  final categoryStream = FirebaseFirestore.instance
      .collection('questions_category')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(height: 20.h),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('questions_category')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCube(color: color.fontcolor, size: 50.0),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: CategoryCard(
                    title: "No categories found   '-'",
                    numofQue: '0',
                    bgColor: color.fontcolor,
                  ),
                );
              }

              final docs = snapshot.data!.docs;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var data = docs[index].data() as Map<String, dynamic>;
                  String categoryName = data['name'] ?? "No Name";
                  String categoryId = docs[index].id;

                  return GestureDetector(
                    onTap: () {
                      print("Tapped on $categoryName");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QuizScreen(categoryName: categoryName),
                        ),
                      );
                    },
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('questions_category')
                          .doc(categoryId)
                          .collection('questions')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: SpinKitThreeBounce(
                              color: color.fontcolor,
                              size: 30.0,
                            ),
                          );
                        }
                        final count = snapshot.data!.docs.length;
                        return CategoryCard(
                          title: categoryName,
                          numofQue: count.toString(),
                          bgColor: color.cardcolor,
                        );
                      },
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
