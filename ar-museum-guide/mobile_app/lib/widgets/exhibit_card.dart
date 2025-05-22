import 'package:flutter/material.dart';

class ExhibitCard extends StatelessWidget {
  final Map<String, dynamic> exhibit;
  final VoidCallback onTap;
  final VoidCallback onQuizTap;

  ExhibitCard({required this.exhibit, required this.onTap, required this.onQuizTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(exhibit['name'] ?? ''),
        subtitle: Text(exhibit['description']?.substring(0, 50) ?? ''),
        onTap: onTap,
        trailing: IconButton(
          icon: Icon(Icons.quiz),
          onPressed: onQuizTap,
        ),
      ),
    );
  }
}