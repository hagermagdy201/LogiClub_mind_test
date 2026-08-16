// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:logiclub/core/utils/classes/assets_image.dart';
// import 'package:logiclub/core/utils/classes/color.dart';
// import 'package:logiclub/features/view_category_screen/presentation/view/view_category_screen.dart';

// class Showdialog extends StatefulWidget {
//   final String rewardValue;
//   const Showdialog({super.key, required this.rewardValue});

//   @override
//   State<Showdialog> createState() => _ShowdialogState();
// }

// class _ShowdialogState extends State<Showdialog> {
//   @override
//   Widget build(BuildContext context) {
//    return ValueListenableBuilder<String>(
//       valueListenable: AssetsPaths.secondaryBackgroundImage,
//       builder: (context, imagePath, child) {
//         final ImageProvider imageProvider = imagePath.startsWith('http')
//             ? NetworkImage(imagePath)
//             : AssetImage(imagePath) as ImageProvider;

//         return
