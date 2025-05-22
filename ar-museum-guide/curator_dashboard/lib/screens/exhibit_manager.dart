import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class ExhibitManager extends StatefulWidget {
  @override
  _ExhibitManagerState createState() => _ExhibitManagerState();
}

class _ExhibitManagerState extends State<ExhibitManager> {
  final FirebaseService _firebaseService = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _modelUrlController = TextEditingController();
  final _audioUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Exhibits')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Exhibit Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _modelUrlController,
                decoration: InputDecoration(labelText: '3D Model URL'),
              ),
              TextFormField(
                controller: _audioUrlController,
                decoration: InputDecoration(labelText: 'Audio Narration URL'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addExhibit,
                child: Text('Add Exhibit'),
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _firebaseService.getExhibits(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    final exhibits = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: exhibits.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(exhibits[index]['name']),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteExhibit(exhibits[index]['id']),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addExhibit() async {
    if (_formKey.currentState!.validate()) {
      await _firebaseService.addExhibit({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'modelUrl': _modelUrlController.text,
        'audioUrl': _audioUrlController.text,
        'quiz_questions': [],
      });
      _nameController.clear();
      _descriptionController.clear();
      _modelUrlController.clear();
      _audioUrlController.clear();
      setState(() {});
    }
  }

  Future<void> _deleteExhibit(String id) async {
    await _firebaseService.deleteExhibit(id);
    setState(() {});
  }
}