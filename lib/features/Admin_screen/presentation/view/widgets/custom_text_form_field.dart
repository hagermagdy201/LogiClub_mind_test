import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLength;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLength = 50,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
      ),
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
        counterStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
      ),
      validator: validator,
    );
  }
}
