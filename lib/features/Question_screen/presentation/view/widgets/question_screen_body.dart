import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Question_screen/presentation/view/widgets/card.dart';
import 'package:logiclub/features/Question_screen/presentation/view/widgets/txt_view_question.dart';

class QuestionScreenBody extends StatelessWidget {
  const QuestionScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.w),
            child: TxtView(
              text: "Choose your category and let’s go",
              fontSize: 55,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 7,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: FruitCard(
                    title: 'Lemon',
                    numofQue: '30',
                    bgColor: color.cardColor,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*

FruitCard(
            title: 'Lemon',
            price: '\$15.7',
            bgColor: const Color(0xFFF9D570),
            imagePath: AssetsPaths.logoImage,
          ),

Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.w),
          child: TxtView(
            text: "Choose your category and let’s go",
            fontSize: 55,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // Text("Choose your category and let’s go"),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemCount: 7,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 10,
                  height: 50,
                  color: Colors.white,
                  // margin: EdgeInsets.all(8.sp),
                ),
              );
            },
          ),
        ),
      ],
    )
 */
