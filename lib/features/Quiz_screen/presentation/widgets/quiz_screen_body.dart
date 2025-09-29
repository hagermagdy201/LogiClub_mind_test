import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;

class QuizScreenBody extends StatefulWidget {
  const QuizScreenBody({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<QuizScreenBody> createState() => _QuizScreenBodyState();
}

class _QuizScreenBodyState extends State<QuizScreenBody> {
  int currentIndex = 0;
  int? selectedIndex;
  int? correctAnswerIndex;
  late AudioPlayer player = AudioPlayer();

  final List<String> successSounds = [
    'Audios/level-up-22268.mp3',
    'Audios/shine-11-268907.mp3',
    'Audios/woman-excited-cheers-and-phrases-says-woohoo-186739.mp3',
  ];

  Future<void> playRandomSuccessSound() async {
    final random = Random();
    int index = random.nextInt(successSounds.length); // رقم عشوائي
    String soundPath = successSounds[index];
    print(":__________________index $index");
    await player.play(
      AssetSource(
        "Audios/woman-excited-cheers-and-phrases-says-woohoo-186739.mp3",
      ),
    );
    Future.delayed(Duration(seconds: 5), () {
      player.stop();
    });
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                child: Text(
                  widget.categoryName,
                  style: TextStyle(
                    color: color.primary,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Chewy",
                  ),
                ),
              ),
              Divider(
                color: color.primary,
                thickness: 3,
                height: 30,
                indent: 200,
                endIndent: 200,
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
                    final questionData =
                        docs[currentIndex].data() as Map<String, dynamic>;

                    final options = [
                      questionData['option1'],
                      questionData['option2'],
                      questionData['option3'],
                      questionData['option4'],
                    ].where((e) => e != null).toList();

                    final correctAnswer = int.tryParse(
                      questionData['correctAnswer'].toString(),
                    );

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 70.w,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(15.w),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Question Text
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(40.w),
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
                                  questionData['question'] ??
                                      'No question text',
                                  style: TextStyle(
                                    color: color.whiteColor,
                                    fontSize: 34.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Chewy",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              SizedBox(height: 50.h),

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
                                    horizontal: 20.w,
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: btnColor,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12.h,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30.r,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          selectedIndex = optionIndex;
                                          correctAnswerIndex = correctAnswer;
                                        });

                                        if ((optionIndex) == correctAnswer) {
                                          // GIF
                                          showDialog(
                                            context: context,
                                            builder: (_) => Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    AssetsPaths.celebrate,
                                                    height: 250,
                                                    width: 250,
                                                  ),
                                                  SizedBox(height: 20),
                                                  Text(
                                                    "Correct Answer! 🎉",
                                                    style: TextStyle(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                          playRandomSuccessSound();
                                          Future.delayed(
                                            Duration(seconds: 2),
                                            () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                currentIndex++;
                                                selectedIndex = null;
                                              });
                                            },
                                          );
                                        } else {
                                          print("إجابة خاطئة ❌");
                                          setState(() {
                                            currentIndex++;
                                            selectedIndex = null;
                                          });
                                        }
                                      },
                                      child: Text(
                                        optionText,
                                        style: TextStyle(
                                          color: color.whiteColor,
                                          fontSize: 32.sp,
                                          fontFamily: "Chewy",
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
