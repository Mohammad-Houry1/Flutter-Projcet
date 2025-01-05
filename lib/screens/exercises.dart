import 'package:flutter/material.dart';
import 'package:workout/models/exercise.dart';
import 'package:workout/services/api_service.dart';

class Exercises extends StatefulWidget {
  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  late Future<List<Exercise>> futureExercises;
  String selectedDifficulty = 'All';
  String selectedMuscleGroup = 'All';

  @override
  void initState() {
    super.initState();
    futureExercises = fetchFilteredExercises();
  }

  Future<List<Exercise>> fetchFilteredExercises() async {
    try {
      ApiService apiService = ApiService();
      List<dynamic> jsonResponse = await apiService.fetchExercises();
      List<Exercise> allExercises =
      jsonResponse.map((data) => Exercise.fromJson(data)).toList();

      // Apply filters
      if (selectedDifficulty != 'All') {
        allExercises = allExercises
            .where((exercise) => exercise.difficulty == selectedDifficulty)
            .toList();
      }
      if (selectedMuscleGroup != 'All') {
        allExercises = allExercises
            .where((exercise) => exercise.category == selectedMuscleGroup)
            .toList();
      }
      return allExercises;
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter Exercises',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Difficulty:',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedDifficulty,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDifficulty = newValue!;
                        futureExercises = fetchFilteredExercises();
                      });
                    },
                    items: <String>[
                      'All',
                      'Beginner',
                      'Intermediate',
                      'Advanced'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category:',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedMuscleGroup,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMuscleGroup = newValue!;
                        futureExercises = fetchFilteredExercises();
                      });
                    },
                    items: <String>[
                      'All',
                      'Chest',
                      'Biceps',
                      'Back',
                      'Shoulders',
                      'Legs',
                      'Triceps'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.network(
              'http://mohammd.wuaze.com/assets/videos/${exercise.video}', // Updated file path
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  exercise.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  '${exercise.category} | ${exercise.targetedMuscle}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 10),
                Text(
                  exercise.description,
                  style: TextStyle(fontSize: 16),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exercises',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildFilterSection(),
          ),
          Expanded(
            child: FutureBuilder<List<Exercise>>(
              future: futureExercises,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text('No exercises match the selected filters.'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _buildExerciseCard(snapshot.data![index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
