import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'title_validator.dart';
import 'task_repository.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskRepository? repository;
  final String? Function()? currentUid;
  const TaskCreatePage({super.key, this.repository, this.currentUid});
  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final txtTitle = TextEditingController();
  bool isSaving = false;
  @override
  void dispose() { txtTitle.dispose(); super.dispose(); }
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  Future<void> save() async {
    if (isSaving) return;
    final error = TitleValidator.validate(txtTitle.text);
    if (error != null) { showMessage(error); return; }
    final uid = widget.currentUid?.call() ??
        (widget.currentUid == null ? FirebaseAuth.instance.currentUser?.uid : null);
    if (uid == null) { showMessage('Faça login para cadastrar uma tarefa.'); return; }
    setState(() => isSaving = true);
    try {
      await (widget.repository ?? FirestoreTaskRepository()).create(
        title: TitleValidator.normalize(txtTitle.text), uid: uid,
      );
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
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('New Task')),
    body: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        TextField(controller: txtTitle, minLines: 1, maxLines: 4,
          decoration: const InputDecoration(border: OutlineInputBorder(),
            labelText: 'Title', helperText: 'Máximo de 100 caracteres')),
        ElevatedButton(onPressed: isSaving ? null : save,
          child: Text(isSaving ? 'Salvando...' : 'Salvar')),
      ]),
    ),
  );
}
