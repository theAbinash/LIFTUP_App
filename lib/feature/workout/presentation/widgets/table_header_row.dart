import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/exercise_column_entity.dart';

class TableHeaderRow extends StatelessWidget {
  final List<ExerciseColumnEntity> columns;
  final ThemeData theme;

  const TableHeaderRow({
    super.key,
    required this.columns,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: columns.map((c) {
          return SizedBox(
            width: c.width,
            child: Text(
              c.label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.grey,
              ),
            ),
          );
        }).toList(),
      ),
      );
  }
}