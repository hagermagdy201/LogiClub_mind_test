import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/assets_sound.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/view_category_screen/presentation/view/view_category_screen.dart';
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

  // متغير لحفظ الـ Future مرة واحدة فقط منعاً للـ Loading المكرر
  late Future<List<Map<String, dynamic>>> giveawaysFuture;

  @override
  void initState() {
    super.initState();
    // جلب الهدايا مرة واحدة عند فتح الشاشة
    giveawaysFuture = getAllGiveaways();
  }

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

  Future<void> playSuccessSound() async {
    String soundPath = AssetsSound.winningsound;
    await player.play(AssetSource(soundPath));
    Future.delayed(const Duration(seconds: 4), () {
      player.stop();
    });
  }

  @override
  void dispose() {
    selected.close();
    player.dispose();
    super.dispose();
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
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Time for Your Gifts! 🎀",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Chewy",
                      fontWeight: FontWeight.bold,
                      color: color.fontcolor,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: giveawaysFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitSpinningLines(
                          color:
                              Colors.white, // أو أي لون يتماشى مع خلفية التطبيق
                          size: 50.0,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text(
                        'No giveaways available',
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      final giveaways = snapshot.data!;
                      return GestureDetector(
                        onTap: () {
                          selected.add(Fortune.randomInt(0, giveaways.length));
                        },
                        child: SizedBox(
                          width: 0.4.sw,
                          height: 0.4.sw,
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
                                        fontSize: 13.sp,
                                        fontFamily: "Chewy",
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
                                        const Color(0xFF00C9FF),
                                    borderColor: color.fontcolor,
                                    borderWidth: 4,
                                    textStyle: TextStyle(
                                      color: color.fontcolor,
                                    ),
                                  ),
                                ),
                            ],
                            onAnimationEnd: () {
                              setState(() {
                                rewardValue =
                                    giveaways[selected.value]['name']
                                        ?.toString() ??
                                    '';
                              });
                              playSuccessSound();

                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: const EdgeInsets.all(16),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 1.sw,
                                        height: 1.sw,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.4,
                                              ),
                                              blurRadius: 15,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          child: Image(
                                            image: imageProvider,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                    vertical: 5,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              maximumSize: const Size(450, 100),
                                              minimumSize: const Size(450, 100),
                                            ),
                                            onPressed: () {
                                              Navigator.of(
                                                context,
                                              ).pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ViewCategoryScreen(),
                                                ),
                                                (route) => route
                                                    .isFirst, // يحذف الشاشات الوسيطة ويبقي على الشاشة الأولى فقط
                                              );
                                            },
                                            child: Text(
                                              'Hope to see you again 👋🏻',
                                              style: TextStyle(
                                                fontSize: 9.sp,
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
      },
    );
  }
}
