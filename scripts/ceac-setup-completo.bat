@echo off
cd /d %~dp0

set "ROOT=../ceac-inteligente"
echo Verificando requisitos do sistema...

where python >nul 2>nul || (
    echo Python nao encontrado. Abrindo site oficial...
    start https://www.python.org/downloads/windows/
    goto FIM
)
where pip >nul 2>nul || (
    echo Pip nao encontrado. Verifique sua instalacao do Python.
    goto FIM
)
where node >nul 2>nul || (
    echo Node.js nao encontrado. Abrindo site oficial...
    start https://nodejs.org/en/download
    goto FIM
)
where npm >nul 2>nul || (
    echo npm nao encontrado. Verifique sua instalacao do Node.
    goto FIM
)

echo Todos os requisitos foram encontrados. Prosseguindo...
echo.

echo Criando estrutura de pastas...

mkdir %ROOT%\backend\api
mkdir %ROOT%\backend\core
mkdir %ROOT%\backend\models
mkdir %ROOT%\backend\schemas
mkdir %ROOT%\backend\services
mkdir %ROOT%\backend\etl
mkdir %ROOT%\frontend\public
mkdir %ROOT%\frontend\src\components
mkdir %ROOT%\frontend\src\pages
mkdir %ROOT%\frontend\src\assets
mkdir %ROOT%\frontend\src\styles
mkdir %ROOT%\material-apresentacao\diagramas
mkdir %ROOT%\material-apresentacao\qr-codes
mkdir %ROOT%\material-apresentacao\videos

echo Criando arquivos principais...

type nul > %ROOT%\backend\main.py
type nul > %ROOT%\backend\logging.py
type nul > %ROOT%\.env.example
type nul > %ROOT%\README.md
type nul > %ROOT%\CHANGELOG.md
type nul > %ROOT%\docker-compose.yml
type nul > %ROOT%\.gitignore

echo Criando ambiente virtual do backend...

python -m venv %ROOT%\venv
call %ROOT%\venv\Scripts\activate.bat

echo Instalando dependencias do backend...
pip install --upgrade pip
pip install fastapi uvicorn loguru pydantic python-multipart python-dotenv
pip freeze > %ROOT%\backend\requirements.txt

echo Preparando frontend com npm...
cd %ROOT%\frontend
if not exist node_modules (
    npm init -y >nul
    npm install vite react react-dom
)
cd ../..

echo Criando scripts auxiliares...

> %ROOT%\executar_ceac.bat (
    echo @echo off
    echo cd /d %%~dp0
    echo start cmd /k "cd backend ^&^& call ..\venv\Scripts\activate.bat ^&^& uvicorn main:app --reload"
    echo start cmd /k "cd frontend ^&^& npm run dev"
    echo echo Servicos iniciados. Backend na porta 8000, frontend na 5173.
    echo pause
)

> %ROOT%\parar_ceac.bat (
    echo @echo off
    echo echo Encerrando processos Uvicorn e Vite...
    echo taskkill /F /IM python.exe /T >nul 2>nul
    echo taskkill /F /IM node.exe /T >nul 2>nul
    echo echo Todos os serviços foram finalizados.
    echo pause
)

echo Setup completo. Use executar_ceac.bat para iniciar e parar_ceac.bat para encerrar os serviços.
pause
:FIM