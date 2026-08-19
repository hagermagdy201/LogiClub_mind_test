import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/home_screen/presentation/view/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Enable offline persistence and keep unlimited cache for Firestore
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  // Enable listening to dynamic assets from Firestore
  AssetsPaths.listenToDynamicAssets();

  // Initialize color values from Firestore
  await color.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // الاستماع المباشر للتغيرات في الألوان وإعادة رسم التطبيق فوراً
    FirebaseFirestore.instance
        .collection('app_settings')
        .doc('theme')
        .snapshots()
        .listen((snapshot) {
          if (snapshot.exists && snapshot.data() != null) {
            if (mounted) {
              setState(() {
                color.updateFromFirestore(snapshot.data()!);
              });
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          key: ValueKey(
            '${color.primary.value}_${color.secondary.value}',
          ), // يضمن إعطاء تنبيه للتطبيق بإعادة الرسم فور تغير الألوان
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
    );
  }
}
