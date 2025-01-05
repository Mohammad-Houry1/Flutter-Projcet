class Exercise {
  final String id;
  final String name;
  final String description;
  final String category;
  final String targetedMuscle;
  final String image;
  final String video;
  final String difficulty;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.targetedMuscle,
    required this.image,
    required this.video,
    required this.difficulty,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      targetedMuscle: json['targeted_muscle'],
      image: json['image'],
      video: json['video'],
      difficulty: json['difficulty'],
    );
  }}


