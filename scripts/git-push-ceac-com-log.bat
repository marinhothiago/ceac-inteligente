@echo off
setlocal
cd /d D:\Empresas\TI\CULTURA\ceac-inteligente

:: Formata data e hora
for /f %%A in ('powershell -command "Get-Date -Format \"yyyy-MM-dd_HH-mm-ss\""') do set DT=%%A

:: Solicita mensagem do usuário
set /p COMMIT_MSG="Mensagem do commit: "
if "%COMMIT_MSG%"=="" set COMMIT_MSG=atualizacao-%DT%

:: Registro no log
echo [%DT%] %COMMIT_MSG% >> git_push.log

:: Git push com upstream
git add .
git commit -m "%COMMIT_MSG%" || echo Nada para commitar.
git push -u origin main

:: Fim
echo.
echo Push realizado com sucesso em %DT%.
pause
