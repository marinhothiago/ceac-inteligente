# Projeto CEAC Inteligente

Este projeto é composto por um frontend (usando Vite) e um backend (usando Python e FastAPI) rodando com Docker. Este README descreve como configurar e atualizar todos os ambientes: local, VS Code, Git e Docker.

## Sumário

- [Requisitos](#requisitos)
- [Configuração do Ambiente Local](#configuração-do-ambiente-local)
- [Configuração do VS Code](#configuração-do-vs-code)
- [Controle de Versão com Git](#controle-de-versão-com-git)
- [Configuração e Uso do Docker](#configuração-e-uso-do-docker)
- [Atualizando Dependências e Imagens](#atualizando-dependências-e-imagens)
- [Scripts Úteis](#scripts-úteis)
- [Troubleshooting](#troubleshooting)

## Requisitos

- **Node.js** (recomendado: 18.x)
- **npm** ou **Yarn**
- **Python 3.11** (para o backend)
- **Docker** e **Docker Compose**
- Acesso à internet para baixar dependências e imagens

## Configuração do Ambiente Local

1. **Clone o repositório:**

   ```bash
   git clone https://seu-repositorio.git
   cd ceac-inteligente
   ```

2. **Instalar dependências do Frontend:**

   - Se usa Yarn:
     ```bash
     cd frontend
     yarn install --ignore-optional
     ```
     > **Nota:** É recomendável não copiar o arquivo `yarn.lock` gerado em ambiente Windows para evitar incompatibilidades com o contêiner Linux.

   - Se usa npm:
     ```bash
     cd frontend
     npm install --legacy-peer-deps --no-optional
     ```

3. **Instalar dependências do Backend:**

   ```bash
   cd ../backend
   pip install -r requirements.txt
   ```

4. **Configurar variáveis de ambiente:**

   - Crie um arquivo `.env` em cada pasta (*frontend* e *backend*) conforme necessário.  
   - Exemplo de `.env` para o backend:
     ```
     DATABASE_URL=postgresql://postgres:senha123@db:5432/ceacdb
     ```

## Configuração do VS Code

1. **Configurações do Workspace:**
   
   - Abra o projeto na raiz com VS Code.
   - Certifique-se de que os arquivos de configuração como `launch.json` e `tasks.json` estejam atualizados para executar e debugar o frontend e backend.
   
2. **Extensões Recomendadas:**
   
   - **ESLint** e **Prettier** para formatação e linting no frontend.
   - **Docker** para gerenciar containers diretamente do VS Code.
   - **GitLens** para aprimorar o controle de versão.
   - **Python** para suporte ao backend (FastAPI).

3. **Sincronização de Configurações:**
   
   - Se usa [Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync), certifique-se de que suas configurações estão atualizadas e sincronizadas entre as máquinas.

## Controle de Versão com Git

1. **Fluxo de Trabalho:**
   
   - **Branching:** Crie branches para novas features ou correções (`feature/nova-funcionalidade`, `bugfix/corrige-erro`).
   - **Commits Frequentes:** Faça commits pequenos e frequentes com mensagens claras.
   
2. **Sincronização com o Remoto:**
   
   - Após testar localmente, faça:
     ```bash
     git add .
     git commit -m "Atualiza dependências/configurações e corrige problemas de ambiente"
     git push origin sua-branch
     ```
   
3. **Integração Contínua (CI):**
   
   - Se há pipeline (por exemplo, GitHub Actions), verifique os logs e teste para garantir que as atualizações não quebrem a build.

## Configuração e Uso do Docker

1. **Dockerfile e docker-compose.yml:**

   - O **frontend** e o **backend** possuem Dockerfiles na raiz de cada pasta.
   - Exemplo de `frontend/Dockerfile` (usando Yarn e removendo lockfile gerado no Windows):

     ```dockerfile
     FROM node:18-slim

     WORKDIR /app

     # Copia package.json (não inclui yarn.lock do host para gerar lockfile Linux)
     COPY package.json ./

     # Instala dependências usando Yarn, ignorando as opcionais
     RUN yarn install --ignore-optional

     # Gambiarra: Cria um dummy para evitar erros do Rollup
     RUN mkdir -p node_modules/@rollup/rollup-linux-x64-gnu && \
         echo "module.exports = {};" > node_modules/@rollup/rollup-linux-x64-gnu/index.js

     # Copia o restante da aplicação
     COPY . .

     EXPOSE 5173

     CMD ["yarn", "dev"]
     ```

   - O `docker-compose.yml` gerencia os containers dos serviços: frontend, backend e db (PostgreSQL). Verifique se as configurações estão corretas conforme o exemplo abaixo:

     ```yaml
     version: '3.8'
     
     services:
       backend:
         build: ./backend
         ports:
           - "8000:8000"
         volumes:
           - ./backend:/app
         depends_on:
           - db
         environment:
           - DATABASE_URL=postgresql://postgres:senha123@db:5432/ceacdb
         restart: always
     
       frontend:
         build: ./frontend
         ports:
           - "5173:5173"
         volumes:
           - ./frontend:/app
           - /app/node_modules
         environment:
           - NODE_ENV=production
         restart: always
     
       db:
         image: postgres:15
         container_name: postgres_ceac
         ports:
           - "5432:5432"
         environment:
           POSTGRES_USER: postgres
           POSTGRES_PASSWORD: senha123
           POSTGRES_DB: ceacdb
         volumes:
           - pgdata:/var/lib/postgresql/data
         restart: always
     
     volumes:
       pgdata:
     ```

2. **Construindo e Rodando Containers:**

   - Para construir e subir os containers, execute:
     ```bash
     docker-compose down && docker system prune -f
     docker-compose up --build
     ```

   - Se precisar forçar a reconstrução sem cache:
     ```bash
     docker-compose build --no-cache
     docker-compose up
     ```

## Atualizando Dependências e Imagens

1. **Localmente e no Repositório:**
   
   - Atualize dependências usando Yarn ou npm conforme explicado na seção "Configuração do Ambiente Local".
   - Após atualizar, commit suas alterações no Git e envie para o repositório remoto.

2. **No Docker:**
   
   - Sempre que atualizar código ou dependências, reconstrua os containers:
     ```bash
     docker-compose down && docker-compose up --build
     ```
   - Use `--no-cache` se as atualizações não estiverem sendo refletidas.
  
3. **VS Code & Git:**
   
   - Mantenha as configurações do VS Code e hooks de Git atualizados conforme as mudanças no projeto.

## Scripts Úteis

Você pode adicionar scripts no `package.json` para facilitar tarefas, por exemplo:

```json
"scripts": {
  "dev": "vite",
  "build": "vite build",
  "docker:up": "docker-compose down && docker-compose up --build",
  "docker:clean": "docker system prune -f",
  "update:deps": "yarn upgrade --latest"
}
```

## Troubleshooting

- **Problemas com Rollup ou dependências nativas:**  
  Se o Rollup reclamar de módulos nativos, verifique a gambiarra (dummy) no Dockerfile. Certifique-se de que o contêiner está gerando um lockfile nativo (Linux) e não o gerado no Windows.

- **Cache de Docker:**  
  Use sempre `docker system prune -f` para remover cache antigo que possa afetar as atualizações.

- **VS Code não sincronizado:**  
  Use o [Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync) para manter todas as configurações atualizadas.

---

