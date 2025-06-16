@echo off
cd /d %~dp0
start cmd /k "cd backend ^&^& ..\venv\Scripts\activate.bat ^&^& uvicorn main:app --reload"
start cmd /k "cd frontend ^&^& npm run dev"
echo Servicos iniciados. Backend na porta 8000, frontend na 5173.
pause
