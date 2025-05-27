# TaskEasy

Aplicativo Flutter para gestão de tarefas em pequenos negócios, permitindo cadastro, listagem, edição, busca, filtro e exclusão de tarefas.

## Proposta do Projeto
O TaskEasy é uma solução para pequenos negócios organizarem tarefas, atribuindo responsáveis, prazos e status. Ideal para equipes de até 20 pessoas.

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