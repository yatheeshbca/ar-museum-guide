import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class QuizScreen extends StatefulWidget {
  final String exhibitId;
  QuizScreen({required this.exhibitId});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  List<dynamic>? questions;
  int currentQuestion = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    final exhibit = await _firebaseService.getExhibitDetails(widget.exhibitId);
    setState(() => questions = exhibit['quiz_questions'] ?? []);
  }

  void _answerQuestion(bool isCorrect) {
    if (isCorrect) setState(() => score++);
    if (currentQuestion < (questions?.length ?? 0) - 1) {
      setState(() => currentQuestion++);
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Completed'),
        content: Text('Your score: $score/${questions?.length ?? 0}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
            child: Text('Back to Home'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questions == null) return Center(child: CircularProgressIndicator());
    if (questions!.isEmpty) return Center(child: Text('No quiz available'));
    final question = questions![currentQuestion];
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(question['question'], style: TextStyle(fontSize: 18)),
            ...question['options'].map((option) => ElevatedButton(
                  onPressed: () => _answerQuestion(option['isCorrect']),
                  child: Text(option['text']),
                )).toList(),
          ],
        ),
      ),
    );
  }
}
