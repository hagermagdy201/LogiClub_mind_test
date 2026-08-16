import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/LandScape_Screen/admin_dashboard_landscape_screen_body.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/Portrait_screen/admin_dashboard_portrait_screen_body.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/showdialogbox.dart';
import 'package:logiclub/features/Settings_screen/presentation/view/Settings_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
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
          'Admin Dashboard',
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPaths.blackbackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: devicemediaorientation == Orientation.portrait
            ? const AdminDashboardScreenBodyPortrait()
            : const AdminDashboardScreenBodyLandscape(),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: devicemediaorientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.03
                : MediaQuery.of(context).size.width * 0.03,
          ),
          // Settings button
          SizedBox(
            height: devicemediaorientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.09
                : MediaQuery.of(context).size.height * 0.09,
            width: devicemediaorientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.13
                : MediaQuery.of(context).size.width * 0.05,
            child: FloatingActionButton(
              heroTag: 'givawayButton',
              onPressed: () async {
                // 💡 الانتظار لحين العودة من شاشة الإعدادات
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
                setState(() {});

                if (mounted) {
                  setState(() {});
                }
              },
              backgroundColor: color.primary,
              child: Icon(
                Icons.settings,
                size: devicemediaorientation == Orientation.portrait
                    ? 12.w
                    : 8.w,
                color: color.fontcolor,
              ),
            ),
          ),
          SizedBox(
            width: devicemediaorientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.03
                : MediaQuery.of(context).size.width * 0.03,
          ),
          // Add quiz button
          SizedBox(
            height: devicemediaorientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.09
                : MediaQuery.of(context).size.height * 0.09,
            width: devicemediaorientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.13
                : MediaQuery.of(context).size.width * 0.05,
            child: FloatingActionButton(
              heroTag: 'quizButton',
              onPressed: () => Showdialogbox().showDialogBox(context),
              backgroundColor: color.primary,
              child: Icon(
                Icons.add,
                size: devicemediaorientation == Orientation.portrait
                    ? 12.w
                    : 8.w,
                color: color.fontcolor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
