import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:logiclub/core/utils/classes/color.dart';

class ImageCardSection extends StatelessWidget {
  final String title;
  final Uint8List? imageBytes;
  final bool isLoading;
  final VoidCallback onTapPick;
  final String emptyText;

  const ImageCardSection({
    super.key,
    required this.title,
    required this.imageBytes,
    required this.isLoading,
    required this.onTapPick,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color.fontcolor,
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 400,
              height: 320,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: imageBytes != null
                    ? DecorationImage(
                        image: MemoryImage(imageBytes!),
                        fit: BoxFit.contain,
                      )
                    : null,
              ),
              child: imageBytes == null
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'No image selected',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    )
                  : null,
            ),

            // مؤشر التحميل
            if (isLoading)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(color: color.primary),
                  ),
                ),
              ),

            // زر الإضافة (+)
            Positioned(
              bottom: 16,
              left: 16,
              child: FloatingActionButton.small(
                heroTag: title,
                onPressed: onTapPick,
                backgroundColor: color.primary,
                elevation: 4,
                child: const Icon(Icons.add, color: Colors.black, size: 26),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 400,
          child: Text(
            imageBytes == null
                ? emptyText
                : 'A new image has been selected and updated. You can choose another image by tapping the (+) button.',
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
