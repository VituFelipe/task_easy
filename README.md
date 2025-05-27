# task_easy

A new Flutter project.

## Getting Started

# TaskEasy

Aplicativo Flutter para gestão de tarefas em pequenos negócios, permitindo cadastro, listagem, edição, exclusão e filtragem de tarefas.

## Proposta do Negócio
O TaskEasy é uma solução simples para pequenos negócios organizarem tarefas, atribuindo responsáveis, prazos e status. Ideal para equipes de até 10 pessoas que buscam otimizar a comunicação e o acompanhamento de atividades.

## Funcionalidades
- **Cadastro de Tarefas**: Adicione tarefas com título, descrição, responsável, data de vencimento e status.
- **Listagem de Tarefas**: Visualize todas as tarefas com opção de filtrar por status (Todos, Pendente, Concluída).
- **Edição e Exclusão**: Edite ou remova tarefas existentes.
- **Validação de Dados**: Campos obrigatórios (título e responsável) são validados.
- **Persistência Local**: Dados salvos em banco SQLite local.

## Requisitos
- Flutter SDK (versão 3.22.2 ou superior)
- Dart
- Dispositivo/emulador Android ou iOS

## Estrutura do Projeto
lib/models/: Contém o modelo Task.
lib/screens/: Telas do aplicativo (TaskFormScreen, TaskListScreen).
lib/services/: Lógica do banco de dados (DatabaseService).
lib/providers/: Gerenciamento de estado (TaskProvider).
Dependências
sqflite: Persistência local.
provider: Gerenciamento de estado.
intl: Formatação de datas.
path_provider: Acesso ao sistema de arquivos.

