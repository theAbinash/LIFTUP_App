import 'package:flutter/material.dart';

class RestTimerButton extends StatelessWidget {
  final bool enabled;
  final int? seconds;
  final VoidCallback onTap;

  const RestTimerButton({
    super.key,
    required this.enabled,
    required this.seconds,
    required this.onTap,
  });

  String get _label {
    if (!enabled) return "Rest Timer: OFF";
    final s = seconds ?? 0;
    final min = s ~/ 60;
    final sec = s % 60;
    if (min == 0) return "Rest Timer: ${sec}s";
    if (sec == 0) return "Rest Timer: ${min}m";
    return "Rest Timer: ${min}m ${sec}s";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.timer_outlined, size: 18, color: Colors.blue),
            const SizedBox(width: 6),
            Text(
              _label,
              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}