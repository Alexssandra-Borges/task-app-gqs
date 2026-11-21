/// Regra RF-002/RF-003: título entre 1 e 100 caracteres após trim.
class TitleValidator {
  static const int maxLength = 100;
  static String? validate(String raw) {
    final title = raw.trim();
    if (title.isEmpty) return 'Informe o título da tarefa.';
    if (title.length > maxLength) return 'O título deve ter no máximo 100 caracteres.';
    return null;
  }
  static String normalize(String raw) => raw.trim();
}
