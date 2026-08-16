import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AssetsPaths {
  static const String _defaultlogoLogiclub = "assets/images/logiclub.png";
  static const String _defaultSecondaryBg = "assets/images/bluenote.png";
  static const String _defaultMainBg = "assets/images/orangebacknote.png";

  static final ValueNotifier<String> logoLogiclub = ValueNotifier(
    _defaultlogoLogiclub,
  );
  static final ValueNotifier<String> secondaryBackgroundImage = ValueNotifier(
    _defaultSecondaryBg,
  );
  static final ValueNotifier<String> mainBackgroundImage = ValueNotifier(
    _defaultMainBg,
  );

  // Local Assets (Unchanged)
  static String logoImageLocal = "assets/images/logoImage.png";
  static String blackbackgroundImage = "assets/images/backnote.png";
  static String whitebackgroundImage = "assets/images/whitenote.png";
  static String happy1 = "assets/images/happy1.jpeg";
  static String happy2 = "assets/images/happy2.jpeg";
  static String happy3 = "assets/images/happy3.jpeg";
  static String happy4 = "assets/images/happy4.jpeg";
  static String happy5 = "assets/images/happy5.jpeg";
  static String happy7 = "assets/images/happy7.jpeg";
  static String sad1 = "assets/images/sad1.jpg";
  static String sad2 = "assets/images/sad2.jpeg";
  static String sad3 = "assets/images/sad3.jpeg";
  static String sad4 = "assets/images/sad4.jpeg";
  static String sad5 = "assets/images/sad5.jpeg";
  static String sad6 = "assets/images/sad6.jpeg";
  static String sad7 = "assets/images/sad7.jpeg";
  static String hayahLogo = "assets/images/Hayah_page_1.png";

  static void listenToDynamicAssets() {
    FirebaseFirestore.instance
        .collection('images')
        .snapshots()
        .listen(
          (snapshot) {
            for (var doc in snapshot.docs) {
              final data = doc.data();
              final String? imageUrl = data['imageUrl'];

              if (imageUrl != null && imageUrl.isNotEmpty) {
                switch (doc.id) {
                  case 'logo':
                    logoLogiclub.value = imageUrl;
                    break;
                  case 'main_bg':
                    mainBackgroundImage.value = imageUrl;
                    break;
                  case 'secondary_bg':
                    secondaryBackgroundImage.value = imageUrl;
                    break;
                }
              }
            }
          },
          onError: (e) {
            debugPrint('Error listening to dynamic assets: $e');
          },
        );
  }
}
