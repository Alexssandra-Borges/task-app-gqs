import 'package:flutter_test/flutter_test.dart';
import 'package:pf_session/title_validator.dart';

void main() {
  group('RF-002/RF-003 — limites do título', () {
    test('CT-02: 0 caracteres rejeitado', () {
      expect(TitleValidator.validate(''), 'Informe o título da tarefa.');
    });
    test('CT-04: 1 caractere aceito', () {
      expect(TitleValidator.validate('A'), isNull);
    });
    test('CT-05: 100 caracteres aceitos', () {
      expect(TitleValidator.validate('A' * 100), isNull);
    });
    test('CT-06: 101 caracteres rejeitados', () {
      expect(TitleValidator.validate('A' * 101), 'O título deve ter no máximo 100 caracteres.');
    });
    test('CT-03: somente espaços rejeitados', () {
      expect(TitleValidator.validate('   '), 'Informe o título da tarefa.');
    });
    test('CT-07: espaços externos normalizados', () {
      expect(TitleValidator.normalize(' Estudar '), 'Estudar');
    });
  });
}
