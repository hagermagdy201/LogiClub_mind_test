import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/Quiz_screen/presentation/widgets/quiz_helpers.dart';
import 'package:logiclub/features/spin_wheel_screen/presentation/spin_wheel_screen.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreenBodyLandscape extends StatefulWidget {
  const QuizScreenBodyLandscape({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<QuizScreenBodyLandscape> createState() => _QuizScreenBodyState();
}

class _QuizScreenBodyState extends State<QuizScreenBodyLandscape> {
  int currentIndex = 0;
  int? selectedIndex;
  int? correctAnswerIndex;
  late Future<List<Map<String, dynamic>>> questionsFuture;

  int shownCount = 0;
  bool isProcessing = false;

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

    final randomTen = allQuestions.length > 5
        ? allQuestions.take(5).toList()
        : allQuestions;

    return randomTen;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: AssetsPaths.secondaryBackgroundImage,
      builder: (context, imagePath, child) {
        final ImageProvider imageProvider = imagePath.startsWith('http')
            ? NetworkImage(imagePath)
            : AssetImage(imagePath) as ImageProvider;

        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                child: FutureBuilder<List<Map<String, dynamic>>>(
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
                              color: color.fontcolor,
                              fontSize: 15.sp,
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
                    return ValueListenableBuilder<String>(
                      valueListenable: AssetsPaths.mainBackgroundImage,
                      builder: (context, imagePath, child) {
                        final ImageProvider imageProvidermain =
                            imagePath.startsWith('http')
                            ? NetworkImage(imagePath)
                            : AssetImage(imagePath) as ImageProvider;

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 0.45.sw,
                              height: 0.43.sw,
                              padding: EdgeInsets.all(15.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                image: DecorationImage(
                                  image: imageProvidermain,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.white.withValues(alpha: 0.2),
                                    BlendMode.srcOver,
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                questionData['question'] ?? 'No question text',
                                style: TextStyle(
                                  color: color.fontcolor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Chewy",
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ...List.generate(options.length, (
                                      optionIndex,
                                    ) {
                                      final optionText =
                                          options[optionIndex] ??
                                          'No option text';
                                      final isSelected =
                                          selectedIndex == optionIndex;

                                      Color btnColor = color.cardcolor;
                                      if (isSelected) {
                                        if (optionIndex == correctAnswer) {
                                          btnColor = Colors.green;
                                        } else {
                                          btnColor = Colors.red;
                                        }
                                      }

                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.h,
                                          horizontal: 5.w,
                                        ),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              disabledBackgroundColor: btnColor,
                                              backgroundColor: btnColor,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 8.h,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.r),
                                              ),
                                            ),
                                            onPressed: isProcessing
                                                ? null
                                                : () {
                                                    setState(() {
                                                      isProcessing = true;
                                                      selectedIndex =
                                                          optionIndex;
                                                      correctAnswerIndex =
                                                          correctAnswer;
                                                    });

                                                    final bool isCorrect =
                                                        optionIndex ==
                                                        correctAnswer;

                                                    Future.delayed(const Duration(seconds: 1), () {
                                                      _increaseShownQuestions();

                                                      showDialog(
                                                        context: context,
                                                        builder: (_) => Dialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          insetPadding:
                                                              const EdgeInsets.all(
                                                                16,
                                                              ),
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              BackdropFilter(
                                                                filter:
                                                                    ImageFilter.blur(
                                                                      sigmaX:
                                                                          10,
                                                                      sigmaY:
                                                                          10,
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
                                                                        ).withValues(
                                                                          alpha:
                                                                              0.3,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Image.asset(
                                                                    isCorrect
                                                                        ? QuizHelpers()
                                                                              .getRandomHappyImage()
                                                                        : QuizHelpers()
                                                                              .getRandomSadImage(),
                                                                    width:
                                                                        150.w,
                                                                    height:
                                                                        150.w,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    isCorrect
                                                                        ? QuizHelpers()
                                                                              .getRandomSuccessfulWord()
                                                                        : QuizHelpers()
                                                                              .getRandomMotivationalWord(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                      height:
                                                                          isCorrect
                                                                          ? 1
                                                                          : 1.3,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );

                                                      if (isCorrect) {
                                                        QuizHelpers()
                                                            .playRandomSuccessSound();
                                                      } else {
                                                        QuizHelpers()
                                                            .PlayRandamFailSound();
                                                      }

                                                      Future.delayed(
                                                        const Duration(
                                                          seconds: 2,
                                                        ),
                                                        () {
                                                          if (!mounted) return;
                                                          Navigator.of(
                                                            context,
                                                          ).pop();
                                                          setState(() {
                                                            if (shownCount ==
                                                                totalQuestions) {
                                                              Navigator.of(
                                                                context,
                                                              ).push(
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (
                                                                        context,
                                                                      ) =>
                                                                          const SpinWheelScreen(),
                                                                ),
                                                              );
                                                            } else {
                                                              selectedIndex =
                                                                  null;
                                                              correctAnswerIndex =
                                                                  null;
                                                              currentIndex++;
                                                              isProcessing =
                                                                  false;
                                                            }
                                                          });
                                                        },
                                                      );
                                                    });
                                                  },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 20.h,
                                                right: 20.h,
                                                bottom: 6.h,
                                                top: 6.h,
                                              ),
                                              child: Text(
                                                optionText,
                                                style: TextStyle(
                                                  color: color.fontcolor,
                                                  fontSize: 14.sp,
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
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
