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

class SpinWheelScreenBodyPortrait extends StatefulWidget {
  const SpinWheelScreenBodyPortrait({super.key});

  @override
  State<SpinWheelScreenBodyPortrait> createState() =>
      _SpinWheelScreenBodyState();
}

class _SpinWheelScreenBodyState extends State<SpinWheelScreenBodyPortrait> {
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
          padding: EdgeInsets.only(top: 40.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Time for Your Gifts! 🎀",
                style: TextStyle(
                  fontSize: 28.sp,
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
            // onPanEnd: (details) {
            //   print(
            //     "_______________________onPanEnd__________________________",
            //   );
            //   setState(() {
            //     selected.add(Fortune.randomInt(0, giveaway.length));
            //   });
            // },
            onTap: () {
              setState(() {
                selected.add(Fortune.randomInt(0, giveaway.length));
              });
            },
            child: SizedBox(
              width: 0.9.sw,
              height: 0.9.sw,
              child: FortuneWheel(
                selected: selected.stream,
                animateFirst: false,
                items: [
                  for (int i = 0; i < giveaway.length; i++)
                    FortuneItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          giveaway[i],
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontFamily: "Chewy",
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true, // 👈 يسمح بلفّ النص تلقائيًا
                          overflow: TextOverflow
                              .visible, // 👈 يخلي النص يظهر كله (مش مقطوع)
                          textAlign: TextAlign.center,
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
                            width: 1.sw,
                            height: 1.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: Offset(0, 8),
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
                                width: 0.8.sw,
                                height: 0.5.sw,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                rewardValue,
                                style: TextStyle(
                                  fontSize: 50,
                                  fontFamily: "Chewy",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: color.primary,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 3,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  maximumSize: Size(400, 100),
                                  minimumSize: Size(400, 100),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Hope to see you again 👋🏻',
                                  style: TextStyle(
                                    fontSize: 20.sp,
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
