import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/btn_view.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/txt_view_home.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;

class HomeViewLandscape extends StatelessWidget {
  const HomeViewLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 1.4,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30.sp),
        ),
        child: Row(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width / 5.5,
              child: Container(
                margin: EdgeInsets.only(bottom: 3.h),
                width: MediaQuery.of(context).size.width / 3,
                child: Image.asset(AssetsPaths.logoLogiclub),
              ),
            ),
            Center(
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
                  SizedBox(height: MediaQuery.of(context).size.height / 18),
                  BtnView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
