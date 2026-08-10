import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/Admin_dashboard_screen.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/LandScape_Screen/video_landscape.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/btn_view.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/txt_view_home.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;

class HomeViewLandscape extends StatelessWidget {
  const HomeViewLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: 0.9.sw,
          height: 0.8.sh,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10.w),
                  child: SizedBox(
                    width: 0.4.sw,
                    child: GestureDetector(
                      onTap: () {
                        print("ooooooooooooooooo");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoLandscape(),
                          ),
                        );
                        print("Logo Tapped");
                      },
                      child: Image.asset(
                        AssetsPaths.logoLogiclub,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 0.5.sw,
                  padding: EdgeInsets.only(right: 10.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TxtView(
                        text: "Welcome!",
                        fontSize: 7.sp.toInt(),
                        weight: FontWeight.bold,
                        color: color.primary,
                      ),
                      SizedBox(height: 8.h),
                      TxtView(
                        text: 'Let’s test your brain power! Ready?',
                        fontSize: 3.sp.toInt(),
                        weight: FontWeight.w500,
                        color: color.primary,
                      ),
                      SizedBox(height: 20.h),
                      BtnView(
                        fontsize: 11,
                        maxsize: 150,
                        minsize: 100,
                        paddingsize: 4,
                      ),
                      SizedBox(height: 10.h),
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
                            fontSize: 5.sp,
                            color: color.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
