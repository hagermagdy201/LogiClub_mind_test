import 'package:flutter/material.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/features/view_category_screen/presentation/view/widgets/view_category_screen_body.dart';

class ViewCategoryScreen extends StatelessWidget {
  const ViewCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
