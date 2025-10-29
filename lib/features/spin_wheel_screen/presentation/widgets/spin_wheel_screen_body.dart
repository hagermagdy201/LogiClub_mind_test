import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/assets_sound.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:rxdart/rxdart.dart';

class SpinWheelScreenBody extends StatefulWidget {
  const SpinWheelScreenBody({super.key});

  @override
  State<SpinWheelScreenBody> createState() => _SpinWheelScreenBodyState();
}

class _SpinWheelScreenBodyState extends State<SpinWheelScreenBody> {
  final selected = BehaviorSubject<int>();
  String rewardValue = "";
  late AudioPlayer player = AudioPlayer();

  List<String> giveaway = ["20% vouchers", "Cap", "Sunshade"];

  Future<void> playSuccessSound() async {
    String soundPath = AssetsSound.winningsound;
    await player.play(AssetSource(soundPath));
    Future.delayed(Duration(seconds: 4), () {
      player.stop();
    });
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
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
              image: AssetImage(AssetsPaths.orangebackgroundImage),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Time for Your Gifts! 🎀",
                style: TextStyle(
                  fontSize: 50.sp,
                  fontFamily: "Chewy",
                  fontWeight: FontWeight.bold,
                  color: color.whiteColor,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selected.add(Fortune.randomInt(0, giveaway.length));
              });
            },
            child: SizedBox(
              width: 700.w,
              height: 700.h,
              child: FortuneWheel(
                selected: selected.stream,
                animateFirst: false,
                items: [
                  for (int i = 0; i < giveaway.length; i++)
                    FortuneItem(
                      child: Text(
                        giveaway[i],
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontFamily: "Chewy",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: FortuneItemStyle(
                        color:
                            Color.lerp(
                              color.snpinwheelPrimaryColor,
                              color.snpinwheelSecondaryColor,
                              i / (giveaway.length - 0.9),
                            ) ??
                            Color(0xFF00C9FF),
                        borderColor: color.whiteColor,
                        borderWidth: 4,
                        textStyle: TextStyle(color: color.whiteColor),
                      ),
                    ),
                ],
                onAnimationEnd: () {
                  setState(() {
                    rewardValue = giveaway[selected.value];
                  });
                  print("-----------------------$rewardValue");
                  playSuccessSound();

                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.all(16),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 1000.w,
                            height: 1000.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                    0.4,
                                  ), // لون الظل
                                  blurRadius: 15, // نعومة الظل
                                  offset: Offset(0, 8), // اتجاه الظل (تحت شوي)
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                AssetsPaths.bluebackgroundImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/win.gif',
                                width: 600.w,
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                rewardValue,
                                style: TextStyle(
                                  fontSize: 70,
                                  fontFamily: "Chewy",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 60.h),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: color.primary,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  maximumSize: Size(600, 100),
                                  minimumSize: Size(600, 100),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Hope to see you again 👋🏻',
                                  style: TextStyle(
                                    fontSize: 40.sp,
                                    fontFamily: "Chewy",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
