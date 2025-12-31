import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/bottom_sheet_menu.dart';
import 'package:liftup/feature/workout/presentation/widgets/custom_bottomsheet.dart';

Future<void> showCustomBottomSheet(BuildContext context,String title, List<BottomSheetMenu> items) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: false, // allows full-screen drag
    backgroundColor: Colors.transparent, // for rounded corners
    barrierColor: Colors.black.withOpacity(0.5), // dim background
    builder: (_) => CustomBottomsheet(title: title ,items: items,)
  );
}