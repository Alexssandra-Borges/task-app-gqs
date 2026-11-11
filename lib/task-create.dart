import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskCreatePage extends StatefulWidget {
  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final TextEditingController txtTitle = TextEditingController();
  bool isSaving = false;
  static const int maxTitleLength = 100;

  @override
  void dispose() {
    txtTitle.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> save() async {
    if (isSaving) return;

    final title = txtTitle.text.trim();
    if (title.isEmpty) {
      showMessage('Informe o título da tarefa.');
      return;
    }
    if (title.length > maxTitleLength) {
      showMessage('O título deve ter no máximo 100 caracteres.');
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showMessage('Faça login para cadastrar uma tarefa.');
      return;
    }

    setState(() => isSaving = true);
    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': title,
        'done': false,
        'uid': user.uid,
      });
      if (!mounted) return;
      Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;
      showMessage('Não foi possível salvar a tarefa. Tente novamente.');
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            TextField(
              controller: txtTitle,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
                helperText: 'Máximo de 100 caracteres',
              ),
            ),
            ElevatedButton(
              onPressed: isSaving ? null : save,
              child: Text(isSaving ? 'Salvando...' : 'Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
