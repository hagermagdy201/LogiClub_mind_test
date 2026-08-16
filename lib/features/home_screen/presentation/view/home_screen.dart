import 'package:flutter/material.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/LandScape_Screen/home_view_landscape.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/Portrait_screen/home_view_portrait.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devicemediaorientation = MediaQuery.of(context).orientation;

    return ValueListenableBuilder<String>(
      valueListenable: AssetsPaths.secondaryBackgroundImage,
      builder: (context, imagePath, child) {
        final ImageProvider imageProvider = imagePath.startsWith('http')
            ? NetworkImage(imagePath)
            : AssetImage(imagePath) as ImageProvider;

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
            ),
            child: devicemediaorientation == Orientation.portrait
                ? const HomeViewPortrait()
                : const HomeViewLandscape(),
          ),
        );
      },
    );
  }
}
