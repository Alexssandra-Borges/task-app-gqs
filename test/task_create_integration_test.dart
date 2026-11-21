import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pf_session/task-create.dart';
import 'package:pf_session/task_repository.dart';

class RecordingRepository implements TaskRepository {
  final entries = <Map<String, Object>>[];
  @override
  Future<void> create({required String title, required String uid}) async {
    entries.add({'title': title, 'done': false, 'uid': uid});
  }
}

void main() {
  testWidgets('CT-01: formulário + repositório gravam título, done e uid', (tester) async {
    final repository = RecordingRepository();
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (context) =>
      Scaffold(body: Center(child: ElevatedButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (_) => TaskCreatePage(repository: repository, currentUid: () => 'uid-teste'))),
        child: const Text('Abrir cadastro'),
      ))))));
    await tester.tap(find.text('Abrir cadastro'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Comprar pão');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(repository.entries, hasLength(1));
    expect(repository.entries.single, {'title': 'Comprar pão', 'done': false, 'uid': 'uid-teste'});
    expect(find.text('Abrir cadastro'), findsOneWidget);
  });
   

  testWidgets('CT-08: formulário rejeita título com apenas espaços',
      (tester) async {
    final repository = RecordingRepository();

    await tester.pumpWidget(
      MaterialApp(
        home: TaskCreatePage(
          repository: repository,
          currentUid: () => 'uid-teste',
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), '   ');
    await tester.tap(find.text('Salvar'));
    await tester.pump();

    expect(repository.entries, isEmpty);
    expect(find.text('Informe o título da tarefa.'), findsOneWidget);
  });


}
