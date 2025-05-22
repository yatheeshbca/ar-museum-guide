class Exhibit {
  final String id;
  final String name;
  final String description;
  final String modelUrl;
  final String audioUrl;
  final List<dynamic> quizQuestions;

  Exhibit({
    required this.id,
    required this.name,
    required this.description,
    required this.modelUrl,
    required this.audioUrl,
    required this.quizQuestions,
  });

  factory Exhibit.fromMap(Map<String, dynamic> map, String id) {
    return Exhibit(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      modelUrl: map['modelUrl'] ?? '',
      audioUrl: map['audioUrl'] ?? '',
      quizQuestions: map['quiz_questions'] ?? [],
    );
  }
}