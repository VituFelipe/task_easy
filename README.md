# TaskEasy

Aplicativo Flutter para gestão de tarefas em pequenos negócios, permitindo organizar atividades com eficiência, atribuir responsáveis e acompanhar prazos.

## Proposta do Projeto
O TaskEasy atende à necessidade de pequenos negócios, como cafeterias, escritórios ou equipes autônomas, de gerenciar tarefas diárias de forma simples e intuitiva. Por exemplo, uma cafeteria pode usar o TaskEasy para atribuir tarefas como "repor estoque" ou "limpar equipamentos" a funcionários, com prazos e status claros, reduzindo falhas de comunicação e aumentando a produtividade.

## Funcionalidades
- **Cadastro de Tarefas**: título, descrição, responsável, data de vencimento e status.
- **Listagem com Busca e Filtros**: busca por título/responsável, filtro por status (Todos, Pendente, Concluída).
- **Edição e Exclusão** individual de tarefas.
- **Limpar Tudo** com confirmação.
- **Validação de Formulário**: título e responsável obrigatórios.
- **Persistência** com SQLite local.
- **Tema Claro/Escuro**: alternância com persistência.
- **Exportar Tarefas** para arquivo JSON.
- **Importar Tarefas** de arquivo JSON (opcional).
- **Notificações Locais** para prazos (opcional).
- **Testes Automatizados** com `flutter test`.

## Requisitos
- Flutter SDK (versão 3.18.0 ou superior)
- Dart SDK (versão 3.2.0 ou superior)
- Dispositivo ou emulador Android/iOS
- Git
- Navegador Chrome (ou emulador Android/iOS)
- VS Code (ou Android Studio)

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
   dart run flutter_launcher_icons
   dart run flutter_native_splash:create
   
4. Execute o aplicativo:
   ```bash
   flutter run

5. Execute os testes:
   ```bash   
   flutter test
Use flutter test para executar os testes automatizados.

## Estrutura do Projeto
```
lib/
├── models/              -> Modelo da Tarefa
├── screens/             -> Telas principais (Formulário e Lista)
├── services/            -> Banco de dados (SQLite)
├── providers/           -> Estado (TaskProvider, ThemeProvider)
assets/                  -> Ícones e splash
test/                    -> Testes automatizados
docs/
├── guia_execucao/       -> Guia Detalhado de Execução
```   

## Guia Detalhado de Execução 
Leia o passo a passo completo em docs/guia_execucao.md

Inclui:

Instalação do Flutter

Permissões em PCs restritos

Geração de splash e ícones

Teste completo de funcionalidades

Solução de problemas

## Sugestões Futuras

- Sincronização com nuvem
- Compartilhamento entre usuários
- Notificações configuráveis
- Importar/exportar para Google Drive

## Autor

Desenvolvido por **Vitu Felipe** – [GitHub](https://github.com/VituFelipe)

---

Feito com 💙 em Flutter

