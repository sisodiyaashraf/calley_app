import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Section title heading for drawer categories, such as "App Info".
class DrawerSectionTitle extends StatelessWidget {
  const DrawerSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        title,
        style: AppTextStyles.drawerSectionTitle,
      ),
    );
  }
}
