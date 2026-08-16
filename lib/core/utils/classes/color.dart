// import 'dart:ui';

// const Color primary = Color(0xFFffa424);
// const Color secondary = Color(0xFF54c4cc);
// const Color fontcolor = Color(0xFFFFFFFF);
// const Color redColor = Color(0xFFD41111);
// const Color greenColor = Color.fromARGB(255, 35, 175, 42);
// const Color blackColor = Color(0xFF2e2d2d);
// const Color fontcolor = Color(0xFFFC846F);
// const Color snpinwheelPrimaryColor = Color.fromARGB(255, 16, 194, 146);
// const Color snpinwheelSecondaryColor = Color(0xFFFFD166);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class color {
  // 1. ألوان ديناميكية تُجلب من Firestore (تم إزالة const لتصبح قابلة للتغيير)
  static Color primary = const Color(0xFFffa424);
  static Color secondary = const Color(0xFF54c4cc);
  static Color fontcolor = const Color(0xFFFFFFFF);
  static Color cardcolor = Color(0xFFFC846F);

  // 2. ألوان ثابته في التطبيق
  static const Color redColor = Color(0xFFD41111);
  static const Color greenColor = Color.fromARGB(255, 35, 175, 42);
  static const Color blackColor = Color(0xFF2e2d2d);
  static const Color snpinwheelPrimaryColor = Color.fromARGB(255, 16, 194, 146);
  static const Color snpinwheelSecondaryColor = Color(0xFFFFD166);

  // 3. دالة جلب الألوان والاستماع للتحديثات من Firestore
  static Future<void> init() async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('app_settings')
          .doc('theme');

      // جلب آخر قيمة مخزنة فور فتح التطبيق
      final doc = await docRef.get();
      if (doc.exists && doc.data() != null) {
        _applyColorData(doc.data()!);
      }

      // الاستماع الحي للحيّة (Real-time stream) للتغيرات القادمة من Firestore
      docRef.snapshots().listen((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          _applyColorData(snapshot.data()!);
        }
      });
    } catch (e) {
      debugPrint('Error loading dynamic colors: $e');
    }
  }

  static void _applyColorData(Map<String, dynamic> data) {
    if (data['primaryColor'] != null) {
      primary = Color(data['primaryColor']);
    }
    if (data['secondaryColor'] != null) {
      secondary = Color(data['secondaryColor']);
    }
    if (data['fontColor'] != null) {
      fontcolor = Color(data['fontColor']);
    }
    if (data['cardColor'] != null) {
      cardcolor = Color(data['cardColor']);
    }
  }

  static void updateFromFirestore(Map<String, dynamic> data) {
    if (data['primaryColor'] != null) {
      primary = Color(data['primaryColor']);
    }
    if (data['secondaryColor'] != null) {
      secondary = Color(data['secondaryColor']);
    }
    if (data['fontColor'] != null) {
      fontcolor = Color(data['fontColor']);
    }
    if (data['cardColor'] != null) {
      cardcolor = Color(data['cardColor']);
    }
  }
}
