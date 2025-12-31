import 'package:flutter/material.dart';

class BottomSheetMenu {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  BottomSheetMenu({
    required this.icon,
    required this.label,
    this.color = Colors.white,
    required this.onTap
  });

}