import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ARMuseumGuideApp());
}

class ARMuseumGuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Museum Guide',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/ar-view': (context) => ARView(
              exhibitId: ModalRoute.of(context)!.settings.arguments as String,
            ),
        '/quiz': (context) => QuizScreen(
              exhibitId: ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}