import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/LandScape_Screen/admin_dashboard_landscape_screen_body.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/Portrait_screen/admin_dashboard_portrait_screen_body.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/showdialogbox.dart';

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
        iconTheme: IconThemeData(
          color: Colors.white,
          size: devicemediaorientation == Orientation.portrait ? 15.sp : 10.sp,
        ),
        backgroundColor: color.blackColor,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
            fontSize: devicemediaorientation == Orientation.portrait
                ? 15.sp
                : 10.sp,
            color: color.whiteColor,
            fontWeight: FontWeight.bold,
          ),
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
            ? AdminDashboardScreenBodyPortrait()
            : AdminDashboardScreenBodyLandscape(),
      ),
      floatingActionButton: SizedBox(
        height: devicemediaorientation == Orientation.portrait
            ? MediaQuery.of(context).size.height * 0.09
            : MediaQuery.of(context).size.height * 0.12,
        width: devicemediaorientation == Orientation.portrait
            ? MediaQuery.of(context).size.width * 0.13
            : MediaQuery.of(context).size.width * 0.09,
        child: FloatingActionButton(
          onPressed: () => Showdialogbox().showDialogBox(context),
          backgroundColor: color.primary,
          child: Icon(
            Icons.add,
            size: devicemediaorientation == Orientation.portrait ? 17.w : 10.w,
            color: color.whiteColor,
          ),
        ),
      ),
    );
  }
}
