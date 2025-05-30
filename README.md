# TaskEasy

Aplicativo Flutter para gestão de tarefas em pequenos negócios, permitindo organizar atividades com eficiência, atribuir responsáveis e acompanhar prazos.

## Proposta do Projeto
O TaskEasy atende à necessidade de pequenos negócios, como cafeterias, escritórios ou equipes autônomas, de gerenciar tarefas diárias de forma simples e intuitiva. Por exemplo, uma cafeteria pode usar o TaskEasy para atribuir tarefas como "repor estoque" ou "limpar equipamentos" a funcionários, com prazos e status claros, reduzindo falhas de comunicação e aumentando a produtividade.

## Funcionalidades
- **Cadastro de Tarefas**: Adicione tarefas com título, descrição, responsável, data de vencimento e status.
- **Listagem de Tarefas**: Visualize com busca por título/responsável, filtro por status (Todos, Pendente, Concluída) e menu para ações globais.
- **Edição e Exclusão**: Modifique ou remova tarefas individualmente.
- **Limpar Tudo**: Exclua todas as tarefas com confirmação via menu.
- **Validação**: Campos obrigatórios (título, responsável) são validados.
- **Persistência**: Dados armazenados no banco SQLite local.
- **Testes**: Teste automatizado para a tela inicial.

## Requisitos
- Flutter SDK (versão 3.18.0 ou superior)
- Dart SDK (versão 3.2.0 ou superior)
- Dispositivo ou emulador Android/iOS

## Como Executar
1. Clone o projeto:
   ```bash
   git clone https://github.com/VituFelipe/task_easy.git

2. Entre no diretório:
   ```bash
   cd task_easy

3. Instale as dependências:
   ```bash
   flutter pub get
   
4. Execute o aplicativo:
   ```bash
   flutter run

5. Execute os testes:
   ```bash   
   flutter test

## Estrutura do Projeto
- lib/models/: Modelo Task.
- lib/screens/: Telas (task_form_screen.dart, task_list_screen.dart).
- l ib/services/: Banco de dados (database_service.dart).
- lib/providers/: Gerenciamento de estado (task_provider.dart, theme_provider.dart).
- test/: Testes automatizados (widget_test.dart).
- assets/: Ícones e recursos visuais.
