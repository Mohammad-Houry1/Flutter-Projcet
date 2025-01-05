import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:workout/models/exercise.dart';

Future<List<Exercise>> loadExercises() async {
  final String response = await rootBundle.loadString('assets/data/exercises.json');
  Iterable data = json.decode(response);
  return List<Exercise>.from(data.map((model) => Exercise.fromJson(model)));
}
