
import 'package:flutter_test/flutter_test.dart';
import '../lib/title_validator.dart';

void main() {
  test('DEF-002 - Título vazio deve ser rejeitado', () {
    final resultado = TitleValidator.validate('');

    expect(resultado, isNotNull);
  });

  test('DEF-002 - Título com espaços deve ser rejeitado', () {
    final resultado = TitleValidator.validate('   ');

    expect(resultado, isNotNull);
  });
}
