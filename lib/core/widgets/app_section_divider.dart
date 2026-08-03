import 'package:flutter/material.dart';

class AppSectionDivider extends StatelessWidget {
  const AppSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: .6,
      indent: 16,
      endIndent: 16,
      color: Theme.of(context).dividerColor,
    );
  }
}