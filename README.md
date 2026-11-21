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

## Demonstração de defeito controlado (corrigido)

Foi introduzido temporariamente o defeito DEF-001 no método `TitleValidator.validate()`, por meio da remoção da condição responsável por rejeitar títulos vazios.
Ao executar `flutter test test/title_validator_test.dart`, os casos CT-02 (título vazio) e CT-03 (somente espaços) falharam, resultando em 4 testes aprovados e 2 reprovados.
Após a identificação do defeito, a condição de validação foi restaurada e a suíte completa foi executada novamente com `flutter test`, obtendo aprovação de todos os 10 testes.
O defeito foi registrado na Issue #3, com o histórico de acompanhamento Aberto → Corrigido → Fechado.
Registro do defeito: https://github.com/Alexssandra-Borges/task-app-gqs/issues/3
O defeito controlado não está presente no código final entregue.

## GitHub Actions
Workflow `.github/workflows/flutter-tests.yml`, executado em push/pull request. Após subir, conferir a aba Actions e copiar o link de execução.
