import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_strings.dart';

/// Helper for launching WhatsApp chat and external YouTube video URLs.
class UrlHelper {
  UrlHelper._();

  static Future<void> launchWhatsApp(
    BuildContext context, [
    String number = AppStrings.whatsappSupportNumber,
  ]) async {
    final uri = Uri.parse('https://wa.me/$number');
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.whatsappError)),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.whatsappError)),
        );
      }
    }
  }

  static Future<void> launchYouTube(String videoId) async {
    final uri = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }
}
