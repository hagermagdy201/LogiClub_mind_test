import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TxtView extends StatelessWidget {
  final String? text;
  final int? fontSize;
  final FontWeight? weight;
  final Color? color;
  const TxtView({
    required this.text,
    required this.fontSize,
    required this.weight,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.w,
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: fontSize?.sp,
          color: color ?? Colors.black87,
          fontWeight: weight ?? FontWeight.normal,
          fontFamily: "Chewy",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
