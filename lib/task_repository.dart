import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TaskRepository {
  Future<void> create({required String title, required String uid});
}

class FirestoreTaskRepository implements TaskRepository {
  @override
  Future<void> create({required String title, required String uid}) async {
    await FirebaseFirestore.instance.collection('tasks').add({
      'title': title, 'done': false, 'uid': uid,
    });
  }
}
