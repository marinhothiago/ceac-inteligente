@echo off
setlocal enabledelayedexpansion

REM Nome da pasta raiz
set "RAIZ=../material-apresentacao"

REM Criar estrutura de pastas
mkdir "%RAIZ%\docs"
mkdir "%RAIZ%\presentation"
mkdir "%RAIZ%\qrcodes"
mkdir "%RAIZ%\videos"
mkdir "%RAIZ%\diagrams"

REM Criar arquivos na pasta docs
for %%F in (
    "CEAC-Documentacao-Tecnica.pdf"
    "CEAC-Documentacao-Tecnica.docx"
    "CEAC-Apresentacao-Institucional.pdf"
    "CEAC-Apresentacao-Institucional.pptx"
    "guia-de-uso-logo.pdf"
    "checklist-entrega-final.pdf"
    "roteiro-pitch-ceac.docx"
    "qa-plano-testes-ceac.pdf"
    "tutorial-acessibilidade.md"
    "CEAC-Arquitetura-Tecnica-Animada.pdf"
) do echo.> "%RAIZ%\docs\%%~F"

REM Criar arquivo na pasta presentation
echo.> "%RAIZ%\presentation\CEAC-Arquitetura-Tecnica-Animada.pptx"

REM Criar arquivos na pasta qrcodes
echo.> "%RAIZ%\qrcodes\qr-release-download.png"
echo.> "%RAIZ%\qrcodes\qr-video-acessibilidade.png"

REM Criar arquivo na pasta videos
echo.> "%RAIZ%\videos\tutorial-acessibilidade-ceac.mp4"

REM Criar arquivos na pasta diagrams
echo.> "%RAIZ%\diagrams\ceac-arquitetura-3tier.svg"
echo.> "%RAIZ%\diagrams\ceac-arquitetura-hexagonal.svg"

echo Estrutura criada com sucesso em "%RAIZ%"
pause
