import 'package:flutter/material.dart';
import 'package:liftup/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:liftup/core/widgets/bottom_sheet/bottom_sheet_item.dart';

class ExercisePopupMenu extends StatelessWidget {
  final VoidCallback? onReorder;
  final VoidCallback? onReplace;
  final VoidCallback? onAddToSuperset;
  final VoidCallback? onRemove;

  const ExercisePopupMenu({
    super.key,
    this.onReorder,
    this.onReplace,
    this.onAddToSuperset,
    this.onRemove,
    });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _open(context), 
      icon: const Icon(Icons.more_vert),
      splashRadius: 20,
    );
  }

  void _open(BuildContext context) {
    AppBottomSheet.show(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetItem(
            title: "Reorder Exercises",
            leading: const Icon(Icons.swap_vert),
            onTap: () {
              Navigator.pop(context);
              onReorder?.call();
            },
          ),

          BottomSheetItem(
            title: "Replace Exercise",
            leading: const Icon(Icons.sync),
            onTap: () {
              Navigator.pop(context);
              onReplace?.call();
            },
          ),

          BottomSheetItem(
            title: "Add To Superset",
            leading: const Icon(Icons.add),
            onTap: () {
              Navigator.pop(context);
              onAddToSuperset?.call();
            },
          ),

          BottomSheetItem(
            title: "Remove Exercise",
            leading: const Icon(Icons.close, color: Colors.red),
            titleColor: Colors.red,
            onTap: () {
              Navigator.pop(context);
              onRemove?.call();
            },
          ),
        ],
      ),
      
    );
  }

}