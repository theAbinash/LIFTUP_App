import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';

class ReorderExercisesPage extends StatefulWidget {
  final List<RoutineExerciseEntity> exercises;

  const ReorderExercisesPage({super.key, required this.exercises});

  @override
  State<ReorderExercisesPage> createState() => _ReorderExercisesPageState();
}

class _ReorderExercisesPageState extends State<ReorderExercisesPage> {
  late List<RoutineExerciseEntity> _items;

  @override
  void initState() {
    super.initState();
    _items = List.of(widget.exercises); // work on a copy
  }

  void _remove(int index) {
    setState(() => _items.removeAt(index));
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reorder"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              itemCount: _items.length,
              onReorder: _reorder,
              itemBuilder: (context, index) {
                final exercise = _items[index];

                return Padding(
                  key: ValueKey(exercise.hashCode),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      /// Remove button
                      GestureDetector(
                        onTap: () => _remove(index),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.remove, color: Colors.white, size: 18),
                        ),
                      ),

                      const SizedBox(width: 14),

                      /// Thumbnail
                      ClipOval(
                        child: Image.network(
                          exercise.exerciseImageUrl ?? "",
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).dividerColor,
                            ),
                            child: const Icon(Icons.fitness_center, size: 20),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      /// Name
                      Expanded(
                        child: Text(
                          exercise.exerciseName ?? "",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),

                      /// Drag handle
                      ReorderableDragStartListener(
                        index: index,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.menu, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// Done button
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _items),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                  child: const Text("Done", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}