import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/Admin_dashboard_screen.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/Portrait_screen/video_potrait.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/btn_view.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/txt_view_home.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:video_player/video_player.dart';

class HomeViewPortrait extends StatefulWidget {
  const HomeViewPortrait({super.key});

  @override
  State<HomeViewPortrait> createState() => _HomeViewPortraitState();
}

class _HomeViewPortraitState extends State<HomeViewPortrait> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: AssetsPaths.logoLogiclub,
      builder: (context, imagePath, child) {
        final ImageProvider imageProvider = imagePath.startsWith('http')
            ? NetworkImage(imagePath)
            : AssetImage(imagePath) as ImageProvider;

        return Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: Column(
              children: [
                SizedBox(
                  width: 1.sw,
                  height: 0.7.sh,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 0.2.sh),
                          width: 0.85.sw,
                          height: 0.7.sh,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(30.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TxtView(
                                  text: "Welcome!",
                                  fontSize: 28.sp.toInt(),
                                  weight: FontWeight.bold,
                                  color: color.primary,
                                ),
                                SizedBox(height: 15.h),
                                TxtView(
                                  text: 'Let’s test your brain power! Ready?',
                                  fontSize: 12.sp.toInt(),
                                  weight: FontWeight.w600,
                                  color: color.primary,
                                ),
                                SizedBox(height: 35.h),
                                BtnView(
                                  fontsize: 22,
                                  maxsize: 200,
                                  minsize: 150,
                                  paddingsize: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.04.sh,
                        left: 0.17.sw,
                        child: SizedBox(
                          width: 0.65.sw,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPotrait(),
                                ),
                              );
                              print("Logo Tapped");
                            },
                            child: Image(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminDashboardScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Continue as Admin',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: color.blackColor,
                      decorationThickness: 2,
                      fontSize: 13.sp,
                      color: color.blackColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
