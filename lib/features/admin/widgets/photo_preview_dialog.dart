import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class PhotoPreviewDialog extends StatelessWidget {
  final String title;
  final String imageUrl;

  const PhotoPreviewDialog({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  static void show(BuildContext context, {required String title, required String imageUrl}) {
    showDialog<void>(
      context: context,
      builder: (ctx) => PhotoPreviewDialog(title: title, imageUrl: imageUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imgWidget;
    if (imageUrl.startsWith('data:image/') && imageUrl.contains(',')) {
      try {
        final bytes = base64Decode(imageUrl.substring(imageUrl.indexOf(',') + 1));
        imgWidget = Image.memory(bytes, fit: BoxFit.contain);
      } catch (_) {
        imgWidget = const Center(child: Icon(Icons.broken_image_outlined, size: 54, color: AppTheme.iconRed));
      }
    } else {
      imgWidget = Image.network(
        imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(Icons.broken_image_outlined, size: 54, color: AppTheme.iconRed),
        ),
      );
    }

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 720),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Close',
                  ),
                ],
              ),
              const Divider(height: 18),
              const Text(
                'Tip: Pinch or double-tap to zoom in/out (up to 4x).',
                style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Container(
                  width: double.infinity,
                  height: 520,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppTheme.bgSurface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InteractiveViewer(
                      minScale: 0.8,
                      maxScale: 4.0,
                      child: imgWidget,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
