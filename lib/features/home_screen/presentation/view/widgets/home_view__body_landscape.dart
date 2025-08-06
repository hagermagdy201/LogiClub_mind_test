import 'package:flutter/material.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/btn_view.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/logo_image_container.dart';
import 'package:logiclub/features/home_screen/presentation/view/widgets/txt_view.dart';

class HomeViewBodyLandscape extends StatelessWidget {
  const HomeViewBodyLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LogoImageContainer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TxtView(),
            SizedBox(height: MediaQuery.of(context).size.height / 12),
            BtnView(),
          ],
        ),
      ],
    );
  }
}
