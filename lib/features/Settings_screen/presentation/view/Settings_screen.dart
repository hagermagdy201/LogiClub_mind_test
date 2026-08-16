import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/Settings_screen/presentation/view/widgets/Settings_landscape_screen_body.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicemediaorientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20.sp,
        iconTheme: IconThemeData(
          color: color.fontcolor,
          size: devicemediaorientation == Orientation.portrait ? 10.sp : 8.sp,
        ),
        backgroundColor: color.blackColor,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: devicemediaorientation == Orientation.portrait
                ? 10.sp
                : 8.sp,
            color: color.fontcolor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
      ),

      body: devicemediaorientation == Orientation.portrait
          ? SettingsLandscapeScreenBody(onRefresh: _refresh)
          : SettingsLandscapeScreenBody(onRefresh: _refresh),
    );
  }
}
