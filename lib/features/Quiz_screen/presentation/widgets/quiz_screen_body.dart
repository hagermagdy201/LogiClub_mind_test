import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;

class QuizScreenBody extends StatefulWidget {
  const QuizScreenBody({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<QuizScreenBody> createState() => _QuizScreenBodyState();
}

class _QuizScreenBodyState extends State<QuizScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsPaths.bluebackgroundImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                child: Text(
                  widget.categoryName,
                  style: TextStyle(
                    color: color.whiteColor,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Chewy",
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('questions_category')
                      .doc(widget.categoryName)
                      .collection('questions')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "No questions found for this category   '-'",
                          style: TextStyle(
                            color: color.whiteColor,
                            fontSize: 30.sp,
                            fontFamily: "Chewy",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final docs = snapshot.data!.docs;

                    return PageView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final questionData =
                            docs[index].data() as Map<String, dynamic>;

                        final options = [
                          questionData['option1'],
                          questionData['option2'],
                          questionData['option3'],
                          questionData['option4'],
                        ].where((e) => e != null).toList();

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 15.w,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(15.w),

                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Qustion text
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          AssetsPaths.orangebackgroundImage,
                                        ),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                          Colors.white.withOpacity(0.4),
                                          BlendMode.srcOver,
                                        ),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      questionData['question'] ??
                                          'No question text',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          255,
                                          255,
                                          255,
                                        ),
                                        fontSize: 28.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  SizedBox(height: 20.h),

                                  // Options
                                  ...List.generate(options.length, (
                                    optionIndex,
                                  ) {
                                    final optionText =
                                        options[optionIndex] ??
                                        'No option text';

                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                        horizontal: 20.w,
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: color.secondary
                                              .withOpacity(0.8),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.h,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          // هنا تعملي مقارنة بين الاختيار و questionData['correctAnswer']
                                          // optionIndex + 1 = رقم الاختيار (عشان عندك option1, option2...)
                                          final isCorrect =
                                              (optionIndex + 1).toString() ==
                                              questionData['correctAnswer']
                                                  .toString();

                                          if (isCorrect) {
                                            print("إجابة صحيحة ✅");
                                          } else {
                                            print("إجابة خاطئة ❌");
                                          }
                                        },
                                        child: Text(
                                          optionText,
                                          style: TextStyle(
                                            color: color.whiteColor,
                                            fontSize: 24.sp,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
