@echo off
echo Encerrando os servidores do backend e frontend...

REM Encerra processos do backend (Python/Uvicorn)
taskkill /F /IM python.exe /T >nul 2>nul
taskkill /F /IM uvicorn.exe /T >nul 2>nul

REM Encerra processos do frontend (Node/Vite)
taskkill /F /IM node.exe /T >nul 2>nul
taskkill /F /IM npm.exe /T >nul 2>nul
taskkill /F /IM vite.exe /T >nul 2>nul

REM Fecha TODOS os terminais CMD abertos
taskkill /F /IM cmd.exe /T >nul 2>nul
