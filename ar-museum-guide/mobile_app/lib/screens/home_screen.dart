import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../widgets/exhibit_card.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AR Museum Guide')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _firebaseService.getExhibits(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final exhibits = snapshot.data ?? [];
          return ListView.builder(
            itemCount: exhibits.length,
            itemBuilder: (context, index) {
              return ExhibitCard(
                exhibit: exhibits[index],
                onTap: () => Navigator.pushNamed(
                  context,
                  '/ar-view',
                  arguments: exhibits[index]['id'],
                ),
                onQuizTap: () => Navigator.pushNamed(
                  context,
                  '/quiz',
                  arguments: exhibits[index]['id'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}