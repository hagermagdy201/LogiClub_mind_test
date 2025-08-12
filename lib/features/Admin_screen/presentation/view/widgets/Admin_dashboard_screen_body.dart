import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDashboardScreenBody extends StatelessWidget {
  const AdminDashboardScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10, // Example item count
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: ListTile(
                  title: Text(
                    'Item $index',
                    style: TextStyle(fontSize: 35.sp, color: Colors.white),
                  ),
                  subtitle: Text(
                    'Details for item $index',
                    style: TextStyle(fontSize: 35.sp, color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete, size: 40.w),
                  ),
                  onTap: () {
                    // Handle tap
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
