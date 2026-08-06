import 'package:flutter/material.dart';
import 'package:liftup/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:liftup/core/widgets/bottom_sheet/bottom_sheet_item.dart';

class RestTimerPicker {
  static const List<int> _presetsSeconds = [15, 30, 45, 60, 90, 120, 180, 240];

  static Future<void> show(
    BuildContext context, {
    required bool currentEnabled,
    required int? currentSeconds,
    required void Function(bool enabled, int? seconds) onChanged,
  }) {
    return AppBottomSheet.show(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetItem(
            title: "Off",
            trailing: !currentEnabled ? const Icon(Icons.check, color: Colors.blue) : null,
            onTap: () {
              onChanged(false, currentSeconds);
              Navigator.pop(context);
            },
          ),
          for (final s in _presetsSeconds)
            BottomSheetItem(
              title: s < 60 ? "${s}s" : "${s ~/ 60}m${s % 60 == 0 ? '' : ' ${s % 60}s'}",
              trailing: currentEnabled && currentSeconds == s
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                onChanged(true, s);
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}