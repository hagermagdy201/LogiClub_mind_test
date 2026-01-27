import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Givaway_screen/presentation/view/widgets/LandScape_Screen/givaway_landscape_screen_body.dart';
import 'package:logiclub/features/Givaway_screen/presentation/view/widgets/Portrait_screen/givaway_portrait_screen_body.dart';

class GivawayScreen extends StatefulWidget {
  const GivawayScreen({super.key});

  @override
  State<GivawayScreen> createState() => _GivawayScreenState();
}

class _GivawayScreenState extends State<GivawayScreen> {
  @override
  Widget build(BuildContext context) {
    final devicemediaorientation = MediaQuery.of(context).orientation;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          size: devicemediaorientation == Orientation.portrait ? 15.sp : 10.sp,
        ),
        backgroundColor: color.blackColor,
        title: Text(
          'Add Givaway',
          style: TextStyle(
            fontSize: devicemediaorientation == Orientation.portrait
                ? 15.sp
                : 10.sp,
            color: color.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.blackbackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: devicemediaorientation == Orientation.portrait
            ? GivawayPortraitScreenBody()
            : GivawayScreenBodyLandscape(),
      ),
    );
  }
}
