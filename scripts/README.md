# CEAC Inteligente – Scripts de Automação

Este diretório contém scripts `.bat` que automatizam tarefas essenciais no desenvolvimento e manutenção do projeto CEAC Inteligente. Eles foram criados para facilitar a configuração, execução e versionamento do projeto de maneira rápida e padronizada.

## Scripts disponíveis

### ceac-setup-completo.bat  
Cria toda a estrutura do projeto CEAC, instala dependências, configura o ambiente virtual (`venv`), prepara o frontend e gera automaticamente outros scripts de execução e parada.  
Local: Raiz do projeto (fora de `/scripts`).  

### executar_ceac.bat  
Inicia dois terminais separados, um para o backend (FastAPI com Uvicorn) e outro para o frontend (React com Vite).  
Backend: `http://localhost:8000`  
Frontend: `http://localhost:5173`  

### parar-ceac.bat  
Finaliza os serviços do backend (`python.exe`) e do frontend (`node.exe`) se estiverem em execução.  
Método: Utiliza `taskkill /F /IM ...` internamente.  

### git-push-ceac-com-log.bat  
Realiza commit e push com:  
- Mensagem customizada + data/hora  
- Registro automático em `git_push.log`  
- Configuração do remote `origin main` na primeira execução  
Extra: Gera um atalho com ícone personalizado na área de trabalho, chamado `Push CEAC`.  

## Estrutura de diretórios material-apresentacao  

Este conjunto de scripts cria automaticamente uma estrutura organizada de pastas para facilitar a gestão do projeto. A organização fica assim:  

material-apresentacao
│── docs
│   ├── CEAC-Documentacao-Tecnica.pdf
│   ├── CEAC-Apresentacao-Institucional.pdf
│   ├── roteiro-pitch-ceac.docx
│   ├── tutorial-acessibilidade.md
│   ├── ...
│── presentation
│   ├── CEAC-Arquitetura-Tecnica-Animada.pptx
│── qrcodes
│   ├── qr-release-download.png
│   ├── qr-video-acessibilidade.png
│── videos
│   ├── tutorial-acessibilidade-ceac.mp4
│── diagrams
│   ├── ceac-arquitetura-3tier.svg
│   ├── ceac-arquitetura-hexagonal.svg

Todos os arquivos acima são criados automaticamente pelos scripts. Se necessário, ajuste os nomes dos arquivos de acordo com a evolução do projeto.  

## Como executar os scripts  

Os scripts podem ser executados de duas maneiras:  

### Via duplo clique  
Basta clicar duas vezes sobre o arquivo `.bat` desejado.  

### Via terminal  
Abra o `cmd` e digite:  

cd scripts
nome-do-script.bat

## Observações importantes  
- Certifique-se de executar os scripts dentro da raiz correta do projeto.  
- Modifique os arquivos conforme necessário para personalizar sua experiência.  
- Caso algum script precise de permissões administrativas, execute-o como Administrador.  

Agora, seu ambiente CEAC Inteligente está pronto para desenvolvimento.