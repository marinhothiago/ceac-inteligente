# Scripts de Automação – CEAC Inteligente

Este diretório contém os scripts `.bat` que automatizam tarefas de desenvolvimento e manutenção do projeto CEAC Inteligente. Eles foram criados para facilitar a configuração, execução e versionamento do projeto de forma rápida e padronizada.

## 🧰 Scripts disponíveis

### 1. `ceac-setup-completo.bat`
Cria toda a estrutura do projeto CEAC, instala dependências, configura venv, prepara o frontend e gera automaticamente os outros arquivos `.bat` de execução e parada. Ideal para rodar logo após clonar o projeto.

> 📌 Local: Raiz do projeto (fora de `/scripts`)

---

### 2. `executar_ceac.bat`
Inicia **dois terminais separados**, um para o backend (FastAPI com Uvicorn) e outro para o frontend (React com Vite).

> Porta backend: `http://localhost:8000`  
> Porta frontend: `http://localhost:5173`

---

### 3. `parar-ceac.bat`
Finaliza os serviços do backend (`python.exe`) e do frontend (`node.exe`) se estiverem em execução.

> Utiliza `taskkill /F /IM ...` internamente

---

### 4. `git-push-ceac-com-log.bat`
Faz commit e push com:

- Mensagem customizada + data/hora
- Registro automático em `git_push.log`
- Configura o remote `origin main` na primeira execução

Cria também um **atalho com ícone personalizado** na área de trabalho, com o nome `Push CEAC`.

---

## 🗂️ Como rodar os scripts

- Execute com duplo clique, ou
- Pelo terminal (`cmd`) com:

```cmd
cd scripts
nome-do-script.bat