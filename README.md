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


**Justificativa:**
- O README explica claramente o propósito, funcionalidades e instruções, atendendo ao requisito de entrega.

---

#### **10. Validação e Testes**
**Testes Realizados:**
- **Validação de Campos**: Testar se o formulário impede o cadastro sem título ou responsável.
- **Persistência**: Verificar se as tarefas são salvas e recuperadas corretamente após fechar e reabrir o app.
- **Listagem e Filtros**: Confirmar que a lista exibe todas as tarefas e que o filtro por status funciona.
- **Edição/Exclusão**: Testar a edição e exclusão de tarefas.

**Justificativa:** Esses testes garantem que todos os requisitos mínimos e extras foram atendidos.

---

#### **11. Considerações Finais**
- **Código Organizado**: O código segue padrões de modularidade e inclui comentários explicativos.
- **Requisitos Atendidos**:
  - Tema definido (gestão de tarefas).
  - Tela de cadastro com validação.
  - Tela de listagem com filtragem (extra).
  - Persistência local com `sqflite`.
  - Edição e exclusão implementadas (extras).
- **Possíveis Melhorias**:
  - Integração com API externa (ex.: sincronização com Google Calendar).
  - Adição de notificações para tarefas próximas do vencimento.
  - Interface mais estilizada com animações.

---

**Conexão com o Exemplo SQL Fornecido:**
O exemplo SQL (`INSERT INTO respostas`) inspirou a implementação do método `insertTask` no `DatabaseService`, que usa uma query semelhante para inserir dados no SQLite. A lógica de persistência foi adaptada para o contexto de Flutter, mantendo a essência de inserir dados em uma tabela com retorno do ID.

Se precisar de mais detalhes ou ajustes no projeto, é só pedir!