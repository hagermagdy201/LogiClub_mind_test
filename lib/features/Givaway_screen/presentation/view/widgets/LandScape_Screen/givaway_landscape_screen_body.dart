import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logiclub/core/utils/classes/color.dart' as color;
import 'package:logiclub/features/Admin_screen/presentation/view/widgets/snackbar.dart';

class GivawayScreenBodyLandscape extends StatefulWidget {
  const GivawayScreenBodyLandscape({super.key});

  @override
  State<GivawayScreenBodyLandscape> createState() =>
      _GivawayScreenBodyLandscapeState();
}

class _GivawayScreenBodyLandscapeState
    extends State<GivawayScreenBodyLandscape> {
  late TextEditingController givawayController;
  final CollectionReference _givawayCollection = FirebaseFirestore.instance
      .collection('Givaway');

  @override
  void initState() {
    super.initState();
    givawayController = TextEditingController();
  }

  @override
  void dispose() {
    givawayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0.w,
          right: 16.0.w,
          top: 20.h,
          bottom: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
              controller: givawayController,
              maxLength: 25,
              decoration: InputDecoration(
                hintText: "Givaway Name",
                hintStyle: TextStyle(
                  color: Color.fromARGB(201, 190, 190, 190),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                counterStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
              ),
            ),

            FilledButton(
              onPressed: () async {
                String giftName = givawayController.text.trim();
                if (giftName.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('Givaway').add({
                    'name': giftName,
                    'timestamp': FieldValue.serverTimestamp(),
                  });
                  givawayController.clear();
                  SnackbarScreen.showSuccess(
                    'Success',
                    'Givaway added successfully',
                    Colors.green,
                  );
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: color.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                minimumSize: Size(90.w, 50.h),
              ),
              child: Text('Add Givaway', style: TextStyle(fontSize: 10.sp)),
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
              margin: EdgeInsets.only(top: 20.h),
              decoration: BoxDecoration(
                color: color.blackColor,
                borderRadius: BorderRadius.circular(8.sp),
              ),
              padding: EdgeInsets.all(8.0.w),
              child: StreamBuilder<QuerySnapshot>(
                stream: _givawayCollection
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No giveaways found'));
                  }

                  final giveaways = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: giveaways.length,
                    itemBuilder: (context, index) {
                      final giveaway = giveaways[index];
                      return ListTile(
                        title: Container(
                          padding: EdgeInsets.all(6.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            color: color.cardColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                giveaway['name'] ?? 'No Name',
                                style: TextStyle(
                                  color: color.blackColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await giveaway.reference.delete();
                                  SnackbarScreen.showSuccess(
                                    'Deleted',
                                    'Givaway deleted successfully',
                                    Colors.red,
                                  );
                                },
                                icon: Icon(
                                  Icons.delete_forever_rounded,
                                  color: color.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
