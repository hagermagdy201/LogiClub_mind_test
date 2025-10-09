import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/view_category_screen/presentation/view/widgets/view_category_screen_body.dart';

class ViewCategoryScreen extends StatelessWidget {
  const ViewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.white, size: 40.sp),
        title: Text(
          "Choose your category and let’s go",
          style: TextStyle(
            color: color.whiteColor,
            fontSize: 55.sp,
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.whitebackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: ViewCategoryScreenBody(),
      ),
    );
  }
}
/*Text(
          'Quiz',
          style: TextStyle(
            color: color.whiteColor,
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ), */