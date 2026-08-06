import 'package:flutter/material.dart';

class ExerciseSetController {
  final TextEditingController weightController;
  final TextEditingController repsController;
  final TextEditingController distanceController;
  final TextEditingController durationController;

  final FocusNode weightFocusNode;
  final FocusNode repsFocusNode;
  final FocusNode distanceFocusNode;
  final FocusNode durationFocusNode;

  ExerciseSetController({
    String weight = '',
    String reps = '',
    String distance = '',
    String duration = '',
  })  : weightController = TextEditingController(text: weight),
        repsController = TextEditingController(text: reps),
        distanceController = TextEditingController(text: distance),
        durationController = TextEditingController(text: duration),
        weightFocusNode = FocusNode(),
        repsFocusNode = FocusNode(),
        distanceFocusNode = FocusNode(),
        durationFocusNode = FocusNode();

  void dispose() {
    weightController.dispose();
    repsController.dispose();
    distanceController.dispose();
    durationController.dispose();

    weightFocusNode.dispose();
    repsFocusNode.dispose();
    distanceFocusNode.dispose();
    durationFocusNode.dispose();
  }
}