import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logiclub/core/utils/classes/assets_image.dart';
import 'package:logiclub/core/utils/classes/color.dart';
import 'package:logiclub/features/Givaway_screen/presentation/view/Givaway_screen.dart';
import 'package:logiclub/features/Settings_screen/presentation/view/widgets/buildHexInputField.dart';
import 'package:logiclub/features/Settings_screen/presentation/view/widgets/buildImageCardSection.dart';

enum ImageType { logo, mainBg, secondaryBg }

class SettingsLandscapeScreenBody extends StatefulWidget {
  final VoidCallback? onRefresh;

  const SettingsLandscapeScreenBody({super.key, this.onRefresh});

  @override
  State<SettingsLandscapeScreenBody> createState() =>
      _SettingsLandscapeScreenBodyState();
}

class _SettingsLandscapeScreenBodyState
    extends State<SettingsLandscapeScreenBody> {
  // ================== image code start ==================

  // 🔑 ضع هنا الـ API Key الخاص بك من موقع ImgBB
  final String _imgBbApiKey = '90fe65f67c7f15d415770d340f67785b';

  Uint8List? _logoBytes;
  bool _isLogoLoading = false;

  Uint8List? _mainBgBytes;
  bool _isMainBgLoading = false;

  Uint8List? _secondaryBgBytes;
  bool _isSecondaryBgLoading = false;

  /// 📥 دالة جلب الصور الحالية المخزنة في Firestore عند فتح الشاشة
  Future<void> _fetchSavedImages() async {
    _setLoading(ImageType.logo, true);
    _setLoading(ImageType.mainBg, true);
    _setLoading(ImageType.secondaryBg, true);

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('images')
          .get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final String? imageUrl = data['imageUrl'];

        if (imageUrl != null && imageUrl.isNotEmpty) {
          // تنزيل بكتات الصورة لتحويلها إلى Uint8List وعرضها في الـ Cards
          final response = await http.get(Uri.parse(imageUrl));
          if (response.statusCode == 200) {
            final Uint8List bytes = response.bodyBytes;
            setState(() {
              if (doc.id == 'logo') {
                _logoBytes = bytes;
              } else if (doc.id == 'main_bg') {
                _mainBgBytes = bytes;
              } else if (doc.id == 'secondary_bg') {
                _secondaryBgBytes = bytes;
              }
            });
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching images from Firestore: $e');
    } finally {
      _setLoading(ImageType.logo, false);
      _setLoading(ImageType.mainBg, false);
      _setLoading(ImageType.secondaryBg, false);
    }
  }

  /// 1. دالة رفع الصورة إلى ImgBB API واسترجاع رابط الصورة المباشر
  Future<String?> _uploadImageToImgBB(Uint8List bytes) async {
    try {
      final Uri url = Uri.parse(
        'https://api.imgbb.com/1/upload?key=$_imgBbApiKey',
      );

      var request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: 'upload_${DateTime.now().millisecondsSinceEpoch}.png',
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['data']['url'];
      } else {
        debugPrint('ImgBB Upload Error: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error uploading to ImgBB: $e');
      return null;
    }
  }

  /// 2. دالة التعامل مع الرفع الكامل: رفع لـ ImgBB ثم حفظ الرابط في Firestore
  Future<void> _processImageUpload(Uint8List bytes, ImageType type) async {
    _setLoading(type, true);

    try {
      String docId;
      switch (type) {
        case ImageType.logo:
          docId = 'logo';
          break;
        case ImageType.mainBg:
          docId = 'main_bg';
          break;
        case ImageType.secondaryBg:
          docId = 'secondary_bg';
          break;
      }

      final String? imageUrl = await _uploadImageToImgBB(bytes);

      if (imageUrl != null) {
        await FirebaseFirestore.instance.collection('images').doc(docId).set({
          'imageUrl': imageUrl,
          'updatedAt': FieldValue.serverTimestamp(),
          'type': docId,
        }, SetOptions(merge: true));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$docId Image uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to upload image to ImgBB server.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving image data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      _setLoading(type, false);
    }
  }

  /// 3. دالة اختيار الصورة من جهاز المستخدم
  Future<void> _pickImage(ImageType type) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes();

      setState(() {
        switch (type) {
          case ImageType.logo:
            _logoBytes = bytes;
            break;
          case ImageType.mainBg:
            _mainBgBytes = bytes;
            break;
          case ImageType.secondaryBg:
            _secondaryBgBytes = bytes;
            break;
        }
      });

      await _processImageUpload(bytes, type);
    }
  }

  void _setLoading(ImageType type, bool isLoading) {
    setState(() {
      switch (type) {
        case ImageType.logo:
          _isLogoLoading = isLoading;
          break;
        case ImageType.mainBg:
          _isMainBgLoading = isLoading;
          break;
        case ImageType.secondaryBg:
          _isSecondaryBgLoading = isLoading;
          break;
      }
    });
  }
  // ================== image code end ==================

  // ================== color theme code start ==================
  final TextEditingController _primaryColorController = TextEditingController(
    text: '#FFffa424',
  );
  final TextEditingController _secondaryColorController = TextEditingController(
    text: '#FF54c4cc',
  );
  final TextEditingController _fontColorController = TextEditingController(
    text: '#FFFFFF',
  );
  final TextEditingController _cardColorController = TextEditingController(
    text: '#FFFC846F',
  );

  Color _previewPrimary = const Color(0xFFffa424);
  Color _previewSecondary = const Color(0xFF54c4cc);
  Color _previewFont = Colors.white;
  Color _previewCard = const Color(0xFFFC846F);

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }

  Future<void> _fetchCurrentTheme() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('app_settings')
          .doc('theme')
          .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;

        setState(() {
          if (data['primaryColor'] != null) {
            _previewPrimary = Color(data['primaryColor']);
            _primaryColorController.text = _colorToHex(_previewPrimary);
          }

          if (data['secondaryColor'] != null) {
            _previewSecondary = Color(data['secondaryColor']);
            _secondaryColorController.text = _colorToHex(_previewSecondary);
          }

          if (data['fontColor'] != null) {
            _previewFont = Color(data['fontColor']);
            _fontColorController.text = _colorToHex(_previewFont);
          }

          if (data['fontcolor'] != null) {
            _previewCard = Color(data['fontcolor']);
            _cardColorController.text = _colorToHex(_previewCard);
          }
        });
      }
    } catch (e) {
      debugPrint('Error fetching theme data: $e');
    }
  }

  bool _isColorSaving = false;

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    String cleanHex = hexString.replaceAll('#', '').trim();
    if (cleanHex.length == 6) {
      buffer.write('ff');
      buffer.write(cleanHex);
    } else if (cleanHex.length == 8) {
      buffer.write(cleanHex);
    } else {
      return Colors.transparent;
    }
    try {
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      return Colors.transparent;
    }
  }

  Future<void> _saveColorsToFirestore() async {
    final primaryColor = _hexToColor(_primaryColorController.text);
    final secondaryColor = _hexToColor(_secondaryColorController.text);
    final fontColor = _hexToColor(_fontColorController.text);
    final cardColor = _hexToColor(_cardColorController.text);

    if (primaryColor == Colors.transparent ||
        secondaryColor == Colors.transparent ||
        fontColor == Colors.transparent ||
        cardColor == Colors.transparent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter valid Hex Color codes (e.g. #FF1E88E5 or #1E88E5)',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isColorSaving = true);
    try {
      await FirebaseFirestore.instance
          .collection('app_settings')
          .doc('theme')
          .set({
            'primaryColorHex': _primaryColorController.text.toUpperCase(),
            'secondaryColorHex': _secondaryColorController.text.toUpperCase(),
            'fontColorHex': _fontColorController.text.toUpperCase(),
            'cardColorHex': _cardColorController.text.toUpperCase(),
            'primaryColor': primaryColor.value,
            'secondaryColor': secondaryColor.value,
            'fontColor': fontColor.value,
            'cardColor': cardColor.value,
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

      color.primary = primaryColor;
      color.secondary = secondaryColor;
      color.fontcolor = fontColor;
      color.cardcolor = cardColor;

      widget.onRefresh?.call();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Theme Hex Colors saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update colors: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isColorSaving = false);
    }
  }

  @override
  void dispose() {
    _primaryColorController.dispose();
    _secondaryColorController.dispose();
    _fontColorController.dispose();
    _cardColorController.dispose();
    super.dispose();
  }

  // ================== color theme code end ==================

  @override
  void initState() {
    super.initState();
    _fetchCurrentTheme();
    _fetchSavedImages(); // 👈 استدعاء جلب الصور المحفوظة عند فتح الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsPaths.blackbackgroundImage),
          fit: BoxFit.fill,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(40.0),
        children: [
          // ================= Section 1: Atrophy & Giveaway =================
          Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: color.blackColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Trophy & Giveaway',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: color.fontcolor,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GivawayScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.card_giftcard, size: 20),
                  label: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color.primary,
                    foregroundColor: color.blackColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ================= Section 2: Hex Color Settings =================
          Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: color.blackColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change App Colors (Hex Format)',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color.fontcolor,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter Hex code (e.g. #FF1E88E5 or #1E88E5)',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildHexInputField(
                      title: 'Primary Color',
                      controller: _primaryColorController,
                      previewColor: _previewPrimary,
                      onChanged: (val) {
                        setState(() {
                          _previewPrimary = _hexToColor(val);
                        });
                      },
                      defualt: '#FFFFa424',
                    ),
                    buildHexInputField(
                      title: 'Secondary Color',
                      controller: _secondaryColorController,
                      previewColor: _previewSecondary,
                      onChanged: (val) {
                        setState(() {
                          _previewSecondary = _hexToColor(val);
                        });
                      },
                      defualt: '#FF54c4cc',
                    ),
                    buildHexInputField(
                      title: 'Card Color',
                      controller: _cardColorController,
                      previewColor: _previewCard,
                      onChanged: (val) {
                        setState(() {
                          _previewCard = _hexToColor(val);
                        });
                      },
                      defualt: '#FFFC846F',
                    ),
                    buildHexInputField(
                      title: 'Font Color',
                      controller: _fontColorController,
                      previewColor: _previewFont,
                      onChanged: (val) {
                        setState(() {
                          _previewFont = _hexToColor(val);
                        });
                      },
                      defualt: '#FFFFFFFF',
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: _isColorSaving ? null : _saveColorsToFirestore,
                    icon: _isColorSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    label: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Save Colors',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color.primary,
                      foregroundColor: color.blackColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ================= Section 3: Images =================
          Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: color.blackColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Image Settings',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color.fontcolor,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Select images to upload via ImgBB API and save links to Firestore',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ImageCardSection(
                        title: 'Change Logo Image',
                        imageBytes: _logoBytes,
                        isLoading: _isLogoLoading,
                        onTapPick: () => _pickImage(ImageType.logo),
                        emptyText: 'Tap the (+) button to select a logo image',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ImageCardSection(
                        title: 'Change Main Background Image',
                        imageBytes: _mainBgBytes,
                        isLoading: _isMainBgLoading,
                        onTapPick: () => _pickImage(ImageType.mainBg),
                        emptyText:
                            'Tap the (+) button to select a background image',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ImageCardSection(
                        title: 'Change Secondary Background Image',
                        imageBytes: _secondaryBgBytes,
                        isLoading: _isSecondaryBgLoading,
                        onTapPick: () => _pickImage(ImageType.secondaryBg),
                        emptyText:
                            'Tap the (+) button to select a background image',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
