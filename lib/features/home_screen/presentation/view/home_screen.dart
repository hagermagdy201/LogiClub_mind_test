import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.bluebackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.h),

              width: MediaQuery.of(context).size.width / 1.5,
              child: Image.asset(AssetsPaths.logoLogiclub),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            SizedBox(
              width: 300.w,
              child: Text(
                'Let’s test your brain power! Ready?',
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Chewy",
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 12),
            ElevatedButton(
              onPressed: () {
                // Respond to button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // شكل الزر
                ),
                padding: EdgeInsets.all(20.sp),
                minimumSize: Size(150.w, 60.h),
                maximumSize: Size(250.w, 90.h), // حجم الزر
              ),
              child: Text(
                'Let’s Goooo',
                style: TextStyle(
                  fontSize: 25.sp,
                  color: color.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
