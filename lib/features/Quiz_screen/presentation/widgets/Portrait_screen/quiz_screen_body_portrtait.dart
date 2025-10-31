import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Quiz_screen/presentation/widgets/quiz_helpers.dart';
import 'package:logiclub/features/spin_wheel_screen/presentation/spin_wheel_screen.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreenBodyPortrtait extends StatefulWidget {
  const QuizScreenBodyPortrtait({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<QuizScreenBodyPortrtait> createState() => _QuizScreenBodyState();
}

class _QuizScreenBodyState extends State<QuizScreenBodyPortrtait> {
  int currentIndex = 0;
  int? selectedIndex;
  int? correctAnswerIndex;
  late Future<List<Map<String, dynamic>>> questionsFuture;

  int shownCount = 0;

  @override
  void initState() {
    super.initState();
    clearAllSharedPrefs();
    questionsFuture = fetchRandomQuestions();
  }

  Future<void> clearAllSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> _increaseShownQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    shownCount = prefs.getInt('shown_questions') ?? 0;
    shownCount++;
    await prefs.setInt('shown_questions', shownCount);
  }

  Future<List<Map<String, dynamic>>> fetchRandomQuestions() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('questions_category')
        .doc(widget.categoryName)
        .collection('questions')
        .get();

    final allQuestions = snapshot.docs.map((e) => e.data()).toList();

    allQuestions.shuffle();

    final randomTen = allQuestions.length > 10
        ? allQuestions.take(10).toList()
        : allQuestions;

    return randomTen;
  }

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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: Text(
                      widget.categoryName,
                      style: TextStyle(
                        color: color.primary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Chewy",
                      ),
                    ),
                  ),
                  Divider(
                    color: color.primary,
                    thickness: 3,
                    height: 30,
                    indent: 150,
                    endIndent: 150,
                  ),

                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: questionsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Center(
                            child: Text(
                              "No questions found for this category '-'",
                              style: TextStyle(
                                color: color.whiteColor,
                                fontSize: 20.sp,
                                fontFamily: "Chewy",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      final questions = snapshot.data!;
                      final totalQuestions = questions.length;

                      final questionData = questions[currentIndex];
                      final options = [
                        questionData['option1'],
                        questionData['option2'],
                        questionData['option3'],
                        questionData['option4'],
                      ].where((e) => e != null).toList();

                      final correctAnswer = int.tryParse(
                        questionData['correctAnswer'].toString(),
                      );
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 0.8.sw,
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              image: DecorationImage(
                                image: AssetImage(
                                  AssetsPaths.orangebackgroundImage,
                                ),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.white.withOpacity(0.2),
                                  BlendMode.srcOver,
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              questionData['question'] ?? 'No question text',
                              style: TextStyle(
                                color: color.whiteColor,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Chewy",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          //Options
                          ...List.generate(options.length, (optionIndex) {
                            final optionText =
                                options[optionIndex] ?? 'No option text';

                            final isSelected = selectedIndex == optionIndex;

                            Color btnColor = color.cardColor;
                            if (isSelected) {
                              if ((optionIndex) == correctAnswer) {
                                btnColor = Colors.green;
                              } else {
                                btnColor = Colors.red;
                              }
                            }

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 35.w,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: btnColor,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex = optionIndex;
                                      correctAnswerIndex = correctAnswer;
                                    });
                                    if ((optionIndex) == correctAnswer) {
                                      Future.delayed(Duration(seconds: 1), () {
                                        print("Correct Answer ✅");
                                        _increaseShownQuestions();

                                        // GIF
                                        showDialog(
                                          context: context,
                                          builder: (_) => Dialog(
                                            backgroundColor: Colors.transparent,
                                            insetPadding: EdgeInsets.all(16),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 10,
                                                    sigmaY: 10,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            46,
                                                            45,
                                                            45,
                                                          ).withOpacity(0.3),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      QuizHelpers()
                                                          .getRandomHappyImage(),
                                                    ),
                                                    const SizedBox(height: 40),
                                                    Text(
                                                      QuizHelpers()
                                                          .getRandomSuccessfulWord(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 45,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        height: 1.3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                        QuizHelpers().playRandomSuccessSound();
                                        Future.delayed(
                                          Duration(seconds: 2),
                                          () {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              if (shownCount ==
                                                  totalQuestions) {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SpinWheelScreen(),
                                                  ),
                                                );
                                              } else {
                                                selectedIndex = null;
                                                correctAnswerIndex = null;
                                                currentIndex++;
                                              }
                                            });
                                          },
                                        );
                                      });
                                    } else {
                                      Future.delayed(Duration(seconds: 1), () {
                                        print("wrong Answer ❌");
                                        _increaseShownQuestions();

                                        // GIF
                                        showDialog(
                                          context: context,
                                          builder: (_) => Dialog(
                                            backgroundColor: Colors.transparent,
                                            insetPadding: EdgeInsets.all(16),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 10,
                                                    sigmaY: 10,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            46,
                                                            45,
                                                            45,
                                                          ).withOpacity(0.3),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      QuizHelpers()
                                                          .getRandomSadImage(),
                                                    ),
                                                    const SizedBox(height: 40),
                                                    Text(
                                                      QuizHelpers()
                                                          .getRandomMotivationalWord(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 45,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        height: 1.3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                        QuizHelpers().PlayRandamFailSound();
                                        Future.delayed(
                                          Duration(seconds: 2),
                                          () {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              if (shownCount ==
                                                  totalQuestions) {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SpinWheelScreen(),
                                                  ),
                                                );
                                              } else {
                                                selectedIndex = null;
                                                correctAnswerIndex = null;
                                                currentIndex++;
                                              }
                                            });
                                          },
                                        );
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 10.h,
                                      right: 10.h,
                                    ),
                                    child: Text(
                                      optionText,
                                      style: TextStyle(
                                        color: color.whiteColor,
                                        fontSize: 28.sp,
                                        fontFamily: "Chewy",
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
