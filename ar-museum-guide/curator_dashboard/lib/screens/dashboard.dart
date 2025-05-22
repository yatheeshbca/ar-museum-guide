import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Curator Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/exhibit-manager'),
              child: Text('Manage Exhibits'),
            ),
            SizedBox(height: 20),
            Text('Welcome to the AR Museum Guide Dashboard'),
          ],
        ),
      ),
    );
  }
}