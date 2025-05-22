import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import '../services/firebase_service.dart';

class ARView extends StatefulWidget {
  final String exhibitId;
  ARView({required this.exhibitId});

  @override
  _ARViewState createState() => _ARViewState();
}

class _ARViewState extends State<ARView> {
  UnityWidgetController? _unityWidgetController;
  final FirebaseService _firebaseService = FirebaseService();
  Map<String, dynamic>? exhibit;

  @override
  void initState() {
    super.initState();
    _loadExhibit();
  }

  Future<void> _loadExhibit() async {
    final data = await _firebaseService.getExhibitDetails(widget.exhibitId);
    setState(() => exhibit = data);
    _unityWidgetController?.postMessage(
      'ARController',
      'LoadExhibit',
      widget.exhibitId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(exhibit?['name'] ?? 'Loading...')),
      body: Stack(
        children: [
          UnityWidget(
            onUnityCreated: (controller) {
              _unityWidgetController = controller;
              _loadExhibit();
            },
          ),
          if (exhibit != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(exhibit!['description'] ?? ''),
                ),
              ),
            ),
        ],
      ),
    );
  }
}