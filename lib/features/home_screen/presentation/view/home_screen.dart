import 'package:flutter/material.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/home_view_landscape.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/home_view_portrait.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devicemediaorientation = MediaQuery.of(context).orientation;
    // print("Device Orientation:-------------------- $devicemediaorientation");
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
        child: devicemediaorientation == Orientation.portrait
            ? HomeViewPortrait()
            : HomeViewLandscape(),
      ),
    );
  }
}
