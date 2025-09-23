import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_log/feature/workout/domain/entities/exercise_entity.dart';
import 'package:gym_log/feature/workout/presentation/pages/exercise_page.dart';

class CreateRoutinePage extends StatefulWidget {
  const CreateRoutinePage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateRoutinePage();
}

class _CreateRoutinePage extends State<CreateRoutinePage> {

  String routineTitle = "";
  final _routineTitleController = TextEditingController();
  List<Map<String, dynamic>> selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {

    List<Map<String, String>> sets = [];

    @override
    void initState(){
      super.initState();
      sets.add({"kg":"", "reps":""});
    }

    void addSet(){
      setState(() {
        sets.add({"kg":"", "reps":""});
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Routine"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              TextFormField(
                controller: _routineTitleController,
                style: TextStyle(
                  color: Colors.grey[850],
                ),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // default line color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // when focused
                  ),
                  hintText: "Routine title",
                  hintStyle: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 22, 
                  ),
                ),
                onChanged: (value) {
                  setState(() => routineTitle = value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an title";
                  }
                  return null;
                },
              ),

            SizedBox(height: 30.h),

            if (selectedWorkouts.isEmpty) ...[
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/dumbbell_icon.png",
                      width: 48,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "No exercises added yet",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemCount: selectedWorkouts.length,
                  itemBuilder: (context, index) {
                    final workout = selectedWorkouts[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(workout['exercise_image_url'] ?? ""),
                                  backgroundColor: Colors.white,
                                  onBackgroundImageError: (_, __) {},
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                child: Text(
                                  workout['exercise_name'] ?? 'Unknown',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_vert, color: Colors.white),
                                onPressed: () {
                                  // bottom sheet actions
                                },
                              ),
                              ],
                            ),

                            const SizedBox(height: 8),
                            // ---- Routine notes ----
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Add routine notes here",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),

                            const SizedBox(height: 10),

                            // ---- Rest Timer row ----
                            Row(
                              children: [
                                const Icon(Icons.timer, color: Colors.grey, size: 20),
                                const SizedBox(width: 6),
                                const Text(
                                  "Rest Timer:",
                                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    workout['rest_timer'] ?? "OFF",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),

                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "SET",
                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "KG",
                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "REPS",
                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),

                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: workout['sets'].length,
                              itemBuilder: (context, setIndex) {
                                final set = workout['sets'][setIndex];
                                return Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart, // swipe right → left
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: const Icon(Icons.delete, color: Colors.white),
                                  ),
                                  onDismissed: (_) {
                                    setState(() {
                                      workout['sets'].removeAt(setIndex);
                                      // re-number sets
                                      for (int i = 0; i < workout['sets'].length; i++) {
                                        workout['sets'][i]['set'] = i + 1;
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      // Set number (auto increment, not editable)
                                      Expanded(
                                        child: Text(
                                          set['set'].toString(),
                                          style: const TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      // KG input
                                      Expanded(
                                        child: TextFormField(
                                          initialValue: set['kg'],
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: const TextStyle(color: Colors.white),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            set['kg'] = value;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      // REPS input
                                      Expanded(
                                        child: TextFormField(
                                          initialValue: set['reps'],
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          style: const TextStyle(color: Colors.white),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            set['reps'] = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 10),

                            // ---- Add Set button ----
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    workout['sets'].add({
                                      "set": workout['sets'].length + 1,
                                      "kg": "",
                                      "reps": "",
                                    });
                                  });
                                },
                                icon: const Icon(Icons.add, color: Colors.white),
                                label: const Text("Add Set"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    /* return Card(
                      color: Colors.grey[900],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(workout['exercise_image_url'] ?? ""),
                                backgroundColor: Colors.white,
                                onBackgroundImageError: (_, __) {},
                              ),
                              
                              SizedBox(width: 10,),

                              Expanded(
                                child: Text(
                                  workout['exercise_name'] ?? 'unknown',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ),

                              IconButton(
                                icon: const Icon(Icons.more_vert, color: Colors.white,),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context, 
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                    ),
                                    builder: (BuildContext ctx) {
                                      return SafeArea(
                                        child: Wrap(
                                          children: [
                                            ListTile(
                                              leading: const Icon(Icons.arrow_outward_rounded),
                                              title: const Text("Reorder Exercises"),
                                              onTap: () {

                                              },
                                            ),
                                            Divider(
                                              color: Colors.grey[800],
                                            ),

                                            ListTile(
                                              leading: const Icon(Icons.replay_circle_filled),
                                              title: const Text("Replace Exercises"),
                                              onTap: () {
                                                
                                              },
                                            ),

                                            Divider(
                                              color: Colors.grey[800],
                                            ),

                                            ListTile(
                                              leading: const Icon(Icons.delete, color: Colors.red,),
                                              title: const Text(
                                                "Remove Exercises",
                                                style: TextStyle(
                                                  color: Colors.red
                                                ),
                                                ),
                                              onTap: () {
                                                Navigator.pop(ctx);
                                                setState(() {
                                                  selectedWorkouts.remove(workout);
                                                });
                                              },
                                            )
                                          ],
                                        )
                                      );
                                    }
                                  );
                                }, 
                              )
                            ],
                          ),

                          const SizedBox(height: 8,),

                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 1, 
                                  decoration: InputDecoration(
                                    hintText: "Add routine notes",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none
                                  ),
                                )
                              )
                            ],
                          ),

                          //SizedBox(height: 10,),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "SET",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "KG",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "REPS",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: workout['sets'].length,
                            itemBuilder: (context, setIndex) {
                              final set = workout['sets'][setIndex];
                              return Dismissible(
                                key: ValueKey("${workout['exercise_id']}_$setIndex"), 
                                direction: DismissDirection.horizontal,
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: const Icon(Icons.delete, color: Colors.white),
                                ),
                                onDismissed: (_) {
                                  setState(() {
                                    (workout['sets'] as List).removeAt(setIndex);
                                    for (int i = 0; i < workout['sets'].length; i++) {
                                      workout['sets'][i]['set'] = i + 1;
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: "${setIndex + 1}",
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none
                                        ),
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ),

                                    SizedBox(width: 10,),

                                    Expanded(
                                      child: TextFormField(
                                        initialValue: set['kg'],
                                        decoration: InputDecoration(
                                          hintText: "-",
                                          hintStyle: TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(color: Colors.white),
                                        onChanged: (value) {
                                          workout['kg'] = value;
                                        },
                                    )
                                    ),

                                  SizedBox(width: 10,),

                                  Expanded(
                                    child: TextFormField(
                                      initialValue: set['reps'],
                                      decoration: InputDecoration(
                                        hintText: "-",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        workout['reps'] = value;
                                      },
                                      style: TextStyle(color: Colors.white),
                                  ),
                                  )

                                  ],
                                ),
                              );
                            }
                          ),

                          SizedBox(height: 10,),

                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  setState(() {
                                    workout['sets'] ??= [];
                                    workout['sets'].add({"kg":"", "reps":""});
                                  });
                                }, 
                                icon: const Icon(Icons.add, color: Colors.white),
                                label: const Text("Add Set"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                            ),
                          )
                            
                          
                        ],
                      )
                    ); */
                  },
                ),
              ),
            ],

          SizedBox(height: 20.h),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const ExercisePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                      )
                  );

                  if (result != null && result is List<ExerciseEntity>) {
                    setState(() {
                      selectedWorkouts.addAll(
                        result.map((ex) => {
                              "exercise_id": ex.exerciseId,
                              "exercise_name": ex.exerciseName,
                              "exercise_image_url": ex.exerciseImageUrl,
                              "sets": [{"kg":"", "reps":""}]
                            }),
                      );
                    });
                  }
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Add Exercise"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          )

          ],
        ),
        )
    );
  }
}

