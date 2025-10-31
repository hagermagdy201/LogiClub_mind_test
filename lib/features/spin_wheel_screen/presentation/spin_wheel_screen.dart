import 'package:flutter/material.dart';
import 'package:logiclub/features/spin_wheel_screen/presentation/widgets/LandScape_Screen/spin_wheel_screen_body_landscape.dart';
import 'package:logiclub/features/spin_wheel_screen/presentation/widgets/Portrait_screen/spin_wheel_screen_body_portrait.dart';

class SpinWheelScreen extends StatelessWidget {
  const SpinWheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devicemediaorientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: devicemediaorientation == Orientation.portrait
          ? SpinWheelScreenBodyPortrait()
          : SpinWheelScreenBodyLandscape(),
    );
  }
}
