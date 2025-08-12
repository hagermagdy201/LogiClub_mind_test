import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/Admin_dashboard_screen.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/btn_view.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/txt_view_home.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;

class HomeViewPortrait extends StatelessWidget {
  const HomeViewPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 1.7,
          // decoration: BoxDecoration(
          //   color: const Color.fromARGB(95, 255, 255, 255),
          //   border: Border.all(
          //     color: const Color.fromARGB(255, 255, 255, 255),
          //     width: 2,
          //   ),
          //   borderRadius: BorderRadius.circular(30.sp),
          // ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5,
                  ),
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30.sp),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TxtView(
                        text: "Welcome!",
                        fontSize: 55,
                        weight: FontWeight.bold,
                        color: color.primary,
                      ),
                      TxtView(
                        text: 'Let’s test your brain power! Ready?',
                        fontSize: 40,
                        weight: FontWeight.w500,
                        color: color.primary,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 22),
                      BtnView(),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 5.5,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Image.asset(AssetsPaths.logoLogiclub),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
            );
          },
          child: Text(
            'Continue as Admin',
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: color.blackColor,
              decorationThickness: 2,
              fontSize: 25.sp,
              color: color.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
