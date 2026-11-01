import 'package:flutter/material.dart';

/// Represents a navigational or functional item in the side drawer.
class DrawerItem {
  const DrawerItem({
    required this.id,
    required this.label,
    required this.icon,
    this.isDestructive = false,
    this.isTappable = true,
  });

  final String id;
  final String label;
  final IconData icon;
  final bool isDestructive;
  final bool isTappable;
}
