import 'package:flutter/material.dart';

class ExerciseInfo extends StatelessWidget {
  final String title;
  final List<String> bodyParts;
  final List<String> equipments;

  const ExerciseInfo({
    super.key,
    required this.title,
    required this.bodyParts,
    required this.equipments,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = [
      ...bodyParts,
      ...equipments,
    ].join(" • ");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),


        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ]
  
      ],
    );
  }
}