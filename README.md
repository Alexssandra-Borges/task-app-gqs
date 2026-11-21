# Task App — GQS Parte 2

Projeto acadêmico Flutter. Testes automatizados do cadastro de tarefas.

## Executar localmente
1. Instale Flutter SDK e execute `flutter doctor`.
2. Execute `flutter create --platforms=android,web .` para gerar as pastas de plataforma ausentes no projeto-base (somente se necessário).
3. Execute `flutter pub get`.
4. Execute `flutter test --reporter expanded`.

O teste CT-01 integra formulário, validação, navegação e repositório em memória (test double). **Não acessa Firestore real**. Para testar Firestore real é necessário ambiente Firebase separado.

## Seleção e rastreabilidade
- CT-02/CT-04: limite inferior (0 e 1), unitário.
- CT-05/CT-06: limite superior (100 e 101), unitário; CT-05 é o teste de regressão após correção controlada.
- CT-01: integração de componentes (interface + repositório injetado), sem rede.
- CT-03 e CT-07: complementares automatizados.

## Demonstração de defeito controlado (não aplicada no código entregue)
Alterar temporariamente `title.length > maxLength` para `title.length >= maxLength` em `lib/title_validator.dart`. Rodar `flutter test test/title_validator_test.dart`: CT-05 deverá falhar. Restaurar `>` e rodar novamente: CT-05 deverá passar. Registrar prints dos dois resultados e os hashes dos commits. **Não afirmar que foi executado sem evidência.**

## GitHub Actions
Workflow `.github/workflows/flutter-tests.yml`, executado em push/pull request. Após subir, conferir a aba Actions e copiar o link de execução.
