import 'dart:convert';

import 'package:liftup/feature/workout/data/models/exercise_model.dart';
import 'package:http/http.dart' as http;

abstract class ExerciseRemoteDataSource {
  Future<List<ExerciseModel>> getExerciseList();
}

class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {

  final http.Client client;
  final String baseUrl;

  ExerciseRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });
  
  @override
  Future<List<ExerciseModel>> getExerciseList() async {
   
   final response = await client.get(Uri.parse(baseUrl));

   if(response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    final List exercise = decoded['data'];
    return exercise.map((e) => ExerciseModel.fromJson(e)).toList();
   } else {
    throw Exception("Failed to fetch exercises: ${response.statusCode}");
   }

  }
  
}