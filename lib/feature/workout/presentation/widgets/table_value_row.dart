import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/feature/workout/domain/entities/exercise_column_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';

class TableValueRow extends StatelessWidget {
  final List<ExerciseColumnEntity> columns;
  final RoutineSetEntity set;
  final ThemeData theme;
  final VoidCallback? onComplete;

  const TableValueRow({
    super.key,
    required this.columns,
    required this.set,
    required this.theme,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: columns.map((c) {
          switch (c.key) {
            case 1:
              return _tableCell(c.width, set.setCount.toString());

            case 2:
              return _inputTableCell(
                c.width, 
                set.setWeight, 
                (v) => set.setWeight = double.tryParse(v),
              );

            case 3:
              return _inputTableCell(
                c.width, 
                set.setRepsCount, 
                (v) => set.setRepsCount = int.tryParse(v),
              );

            case 4:
              return _inputTableCell(
                c.width, 
                set.setDuration, 
                (v) => set.setDuration = int.tryParse(v),
              );

            case 5:
              return _inputTableCell(
                c.width, 
                set.setDistance, 
                (v) => set.setDistance = int.tryParse(v),
              );

            case 6:
              return SizedBox(
                width: c.width,
                child: IconButton(
                  icon: Icon(
                    set.isCompleted
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: set.isCompleted ? Colors.green : Colors.grey,
                  ),
                  onPressed: onComplete,
                ),
              );

            default:
              return const SizedBox.shrink();
          }
        }).toList(),
      );
  }

  Widget _tableCell(double width, String text) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: theme.textTheme.bodySmall,
      ),
    );
  }

  Widget _inputTableCell(double width, num? value, Function(String) onChanged,) {
    return SizedBox(
    width: width,
    child: TextFormField(
      initialValue: (value == null || value == 0) ? '-' : value.toString(),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
    ),
  );
  }


}