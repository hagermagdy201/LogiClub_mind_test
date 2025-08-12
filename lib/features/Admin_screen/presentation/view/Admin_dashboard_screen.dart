import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/Admin_dashboard_screen_body.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(5.0),
        //   child: Container(color: color.blackColor, height: 20.0),
        // ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop;
        //   },
        //   icon: Icon(Icons.arrow_back, color: color.whiteColor),
        // ),
        backgroundColor: color.blackColor,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
            fontSize: 30.sp,
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
        child: AdminDashboardScreenBody(),
      ),
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.13,
        child: FloatingActionButton(
          onPressed: () => _showDialogBox(context),
          backgroundColor: color.primary,
          child: Icon(Icons.add, size: 60.w, color: color.whiteColor),
        ),
      ),
    );
  }

  void _showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height * 0.1,
          child: SimpleDialog(
            title: Text("Add New Quiz"),
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Quiz Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Add Quiz"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ),
            ],
            // backgroundColor: color.blackColor,
          ),
        );
      },
    );
  }
}
