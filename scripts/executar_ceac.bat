@echo off
cd /d %~dp0

REM Verifica se o ambiente virtual existe antes de ativar
if not exist ..\venv\Scripts\activate.bat (
    echo ERRO: Ambiente virtual nao encontrado.
    pause
    exit
)

REM Verifica se as pastas backend e frontend existem antes de iniciar os serviços
if not exist ..\backend (
    echo ERRO: Pasta backend nao encontrada.
    pause
    exit
)
if not exist ..\frontend (
    echo ERRO: Pasta frontend nao encontrada.
    pause
    exit
)

REM Inicia o backend com HTTP e HTTPS
start cmd /k "cd ..\backend && call ..\venv\Scripts\activate.bat && uvicorn main:app --host 127.0.0.1 --port 8000 --ssl-keyfile=server.key --ssl-certfile=server.pem --reload"

REM Inicia o frontend
start cmd /k "cd ..\frontend && npm run dev"

echo Servicos iniciados. Backend na porta 8000 com HTTP e HTTPS, frontend na 5173.
pause