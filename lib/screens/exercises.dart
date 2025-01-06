import 'package:flutter/material.dart';
import '../services/api_service.dart';

class Exercises extends StatefulWidget {
  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.fetchExercises(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final exercises = snapshot.data!;
              return ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: exercise['image'] != null
                          ? Image.network(
                        "http://mohammd.wuaze.com/assets/images/" + (exercise['image'] ?? ''),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                      )
                          : Icon(Icons.image_not_supported),
                      title: Text(
                        exercise['name'] ?? 'No name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        exercise['description'] ?? 'No description available',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        exercise['difficulty'] ?? 'Unknown',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              return Center(child: Text("No exercises available"));
            }
          } else {
            return Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}
