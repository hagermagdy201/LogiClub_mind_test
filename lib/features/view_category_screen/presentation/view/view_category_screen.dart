import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/view_category_screen/presentation/view/widgets/Portrait_screen/view_category_screen_body_portrait.dart';
import 'package:logiclub/features/view_category_screen/presentation/view/widgets/LandScape_screen%27/view_category_screen_body_LandScape.dart';

class ViewCategoryScreen extends StatelessWidget {
  const ViewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devicemediaorientation = MediaQuery.of(context).orientation;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 110,
        iconTheme: IconThemeData(
          color: color.fontcolor,
          size: 16.sp,
          weight: 900,
        ),
        title: Text(
          "Choose your category and let’s go",
          style: TextStyle(
            color: color.fontcolor,
            fontSize: devicemediaorientation == Orientation.portrait
                ? 20.sp
                : 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Chewy",
          ),
          // maxLines: 4,sr
          // overflow: TextOverflow.visible, // عشان ما يقطعش النص
          // textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 5.sp),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.whitebackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: devicemediaorientation == Orientation.portrait
            ? const ViewCategoryScreenBodyPortrait()
            : const ViewCategoryScreenBodyLandscape(),
      ),
    );
  }
}
