import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';

class LogoImageContainer extends StatelessWidget {
  const LogoImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      width: MediaQuery.of(context).size.width / 1.5,
      child: Image.asset(AssetsPaths.logoLogiclub),
    );
  }
}
