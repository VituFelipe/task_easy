# Guia de Execução – TaskEasy

Este guia descreve como configurar e executar o projeto **TaskEasy** em outro computador, como os da universidade. Inclui pré-requisitos, comandos necessários, testes e dicas para solucionar problemas comuns.

---

## 1. Pré-requisitos

Garanta que os seguintes softwares estejam instalados:

- **Flutter SDK** `>=3.22.0`
  - Baixe em [flutter.dev](https://flutter.dev)
  - Adicione `flutter/bin` ao PATH
  - Verifique com:
    ```bash
    flutter doctor
    ```

- **Dart SDK** `>=3.7.2 <4.0.0`
  - Incluído com o Flutter

- **Git**
  - Verifique com:
    ```bash
    git --version
    ```

- **Ambiente de Execução**
  - **Chrome** (recomendado para testes rápidos via web)
  - **Emulador Android ou dispositivo físico** (opcional)
  - **Editor**: VS Code com extensões Flutter e Dart, ou Android Studio

---

##  2. Clonar o Projeto

Abra o terminal e execute:

```bash
git clone https://github.com/VituFelipe/task_easy.git
cd task_easy
```

---

##  3. Configurar o Ambiente

Instale as dependências:

```bash
flutter pub get
```

Verifique se tudo está ok com:

```bash
flutter doctor
```

---

##  4. Gerar Ícone e Splash Screen

Gere o ícone do app:

```bash
dart run flutter_launcher_icons
```

Gere a tela de splash:

```bash
dart run flutter_native_splash:create
```

---

##  5. Executar o Aplicativo

Limpe o cache (opcional, recomendado em novos ambientes):

```bash
flutter clean
flutter pub get
```

Execute o app:

```bash
flutter run
```

Selecione **Chrome** como destino se não estiver usando emulador.

---

##  6. Testar Funcionalidades

### Cadastro de Tarefas
- Clique em `+` para adicionar uma tarefa
- Preencha **título**, **responsável**, **data**, **status**
- Campos obrigatórios são validados

### Listagem e Filtros
- Visualize tarefas por título ou responsável
- Filtro por status: Todos, Pendente, Concluída

### Ações no Menu
- **Limpar Todas**: remove todas as tarefas com confirmação
- **Exportar Tarefas**: gera JSON no diretório local
- **Alternar Tema**: muda entre tema claro/escuro
- **Importar Tarefas** (se habilitado): lê arquivo `tasks_export.json`

### Persistência com SQLite
- Os dados são salvos no dispositivo (ex.: `task_easy.db` no `AppData` no Windows)
- Ao fechar e reabrir o app, os dados permanecem

---

##  7. Executar Testes

Rode os testes automatizados:

```bash
flutter test
```

Verifique se o teste `exports tasks to JSON` passa com sucesso.

---

##  8. Solução de Problemas

| Problema                        | Solução                                                                 |
|---------------------------------|-------------------------------------------------------------------------|
| `flutter` não encontrado        | Instale o SDK e configure o PATH corretamente                          |
| Dependências não instalam       | Verifique conexão com internet e execute `flutter pub get` novamente   |
| Permissões negadas              | Use diretórios com permissão (ex.: Desktop) ou peça ajuda ao administrador |
| SQLite não salva dados          | Verifique se o arquivo `task_easy.db` está sendo criado corretamente   |
| Testes falham                   | Compartilhe o log de erro e revise o código                           |

---

##  9. Importação de Tarefas (Opcional)

Se a funcionalidade estiver ativada:

- Copie o arquivo `tasks_export.json` para o diretório de documentos do app
- Use a opção **Importar Tarefas** no menu

---

##  10. Atualizar o Repositório (Opcional)

Se fizer ajustes locais:

```bash
git add .
git commit -m "Ajustes para execução no computador da universidade"
git push origin main
```

---

##  Resumo dos Comandos

```bash
git clone https://github.com/VituFelipe/task_easy.git
cd task_easy
flutter pub get
dart run flutter_launcher_icons
dart run flutter_native_splash:create
flutter clean
flutter run
flutter test
```

---
