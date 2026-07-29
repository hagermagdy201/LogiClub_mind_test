import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/assets_sound.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:rxdart/rxdart.dart';

class SpinWheelScreenBodyLandscape extends StatefulWidget {
  const SpinWheelScreenBodyLandscape({super.key});

  @override
  State<SpinWheelScreenBodyLandscape> createState() =>
      _SpinWheelScreenBodyState();
}

class _SpinWheelScreenBodyState extends State<SpinWheelScreenBodyLandscape> {
  final selected = BehaviorSubject<int>();
  String rewardValue = "";
  late AudioPlayer player = AudioPlayer();

  // List<String> giveaway = ["20% vouchers", "Cap", "Sunshade"];
  Future<List<Map<String, dynamic>>> getAllGiveaways() async {
    CollectionReference giveaways = FirebaseFirestore.instance.collection(
      'Givaway',
    );

    QuerySnapshot snapshot = await giveaways.get();

    List<Map<String, dynamic>> allGiveaways = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();

    return allGiveaways;
  }

  Future<List<Map<String, dynamic>>> get giveaway async =>
      await getAllGiveaways();

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
          padding: EdgeInsets.only(top: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Time for Your Gifts! 🎀",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: "Chewy",
                  fontWeight: FontWeight.bold,
                  color: color.whiteColor,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getAllGiveaways(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No giveaways available');
                } else {
                  final giveaways = snapshot.data!;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected.add(Fortune.randomInt(0, giveaways.length));
                      });
                    },
                    child: SizedBox(
                      width: 0.45.sw,
                      height: 0.45.sw,
                      child: FortuneWheel(
                        selected: selected.stream,
                        animateFirst: false,
                        items: [
                          for (int i = 0; i < giveaways.length; i++)
                            FortuneItem(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 26.0,
                                  right: 26.0,
                                  top: 18.0,
                                  bottom: 18.0,
                                ),
                                child: Text(
                                  giveaways[i]['name']?.toString() ?? '',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: "Chewy",
                                    // fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              style: FortuneItemStyle(
                                color:
                                    Color.lerp(
                                      color.snpinwheelPrimaryColor,
                                      color.snpinwheelSecondaryColor,
                                      i / (giveaways.length - 0.9),
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
                            rewardValue =
                                giveaways[selected.value]['name']?.toString() ??
                                '';
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
                                        width: 0.5.sw,
                                        height: 0.3.sw,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(height: 20.h),
                                      Text(
                                        rewardValue,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontFamily: "Chewy",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: color.primary,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 5,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          maximumSize: Size(450, 100),
                                          minimumSize: Size(450, 100),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Hope to see you again 👋🏻',
                                          style: TextStyle(
                                            fontSize: 15.sp,
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
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
