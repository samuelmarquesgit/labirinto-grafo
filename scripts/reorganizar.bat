@echo off
REM =============================================================================
REM Reorganizar arquivos para estrutura correta
REM =============================================================================

cd /d "%~dp0"

echo.
echo ╔═══════════════════════════════════════════════════════════════╗
echo ║         REORGANIZANDO ESTRUTURA DO PROJETO                   ║
echo ╚═══════════════════════════════════════════════════════════════╝
echo.

REM =========================================================================
REM 1. MOVER .md PARA docs/
REM =========================================================================

echo [1/5] Movendo arquivos .md para docs/...

if exist "AGENTS_PLAN.md" move /Y "AGENTS_PLAN.md" "docs\" >nul && echo  ✓ AGENTS_PLAN.md
if exist "BATCH_SCRIPTS_ARCHIVE.md" move /Y "BATCH_SCRIPTS_ARCHIVE.md" "docs\" >nul && echo  ✓ BATCH_SCRIPTS_ARCHIVE.md
if exist "SCRIPTS_ARCHIVE.md" move /Y "SCRIPTS_ARCHIVE.md" "docs\" >nul && echo  ✓ SCRIPTS_ARCHIVE.md
if exist "LIMPEZA_CHECKLIST.md" move /Y "LIMPEZA_CHECKLIST.md" "docs\" >nul && echo  ✓ LIMPEZA_CHECKLIST.md
if exist "ISSUES_TO_CREATE.md" move /Y "ISSUES_TO_CREATE.md" "docs\" >nul && echo  ✓ ISSUES_TO_CREATE.md

REM BRANCHING_STRATEGY.md e QUICK_START_BRANCHING.md já estão em docs/

echo.
echo [2/5] Movendo scripts .bat/.ps1 para scripts/...

if exist "LIMPAR.ps1" move /Y "LIMPAR.ps1" "scripts\" >nul && echo  ✓ LIMPAR.ps1
if exist "limpar-agora.bat" move /Y "limpar-agora.bat" "scripts\" >nul && echo  ✓ limpar-agora.bat

echo.
echo [3/5] Movendo testes para test/...

if exist "testes.c" move /Y "testes.c" "test\" >nul && echo  ✓ testes.c
if exist "teste-som.c" move /Y "teste-som.c" "test\" >nul && echo  ✓ teste-som.c

echo.
echo [4/5] Movendo executáveis para bin/...

if exist "testes.exe" move /Y "testes.exe" "bin\" >nul && echo  ✓ testes.exe
if exist "teste-som.exe" move /Y "teste-som.exe" "bin\" >nul && echo  ✓ teste-som.exe
if exist "labirinto.exe" move /Y "labirinto.exe" "bin\" >nul && echo  ✓ labirinto.exe

echo.
echo [5/5] Deletando scripts temporários da raiz...

if exist "run-tests.bat" del /f /q "run-tests.bat" >nul && echo  ✓ run-tests.bat deletado
if exist "scripts.bat" del /f /q "scripts.bat" >nul && echo  ✓ scripts.bat deletado

echo.
echo ╔═══════════════════════════════════════════════════════════════╗
echo ║              ✅ REORGANIZAÇÃO CONCLUÍDA!                      ║
echo ╚═══════════════════════════════════════════════════════════════╝
echo.

echo Estrutura final (raiz):
echo   ✓ .gitignore
echo   ✓ main.c
echo   ✓ labirinto.c
echo   ✓ labirinto.h
echo   ✓ visualizacao.c
echo   ✓ visualizacao.h
echo   ✓ README.md
echo   ✓ Planejamento.md
echo   ✓ build.bat
echo.

echo Pastas:
echo   ✓ docs/          (toda documentação)
echo   ✓ scripts/       (scripts .bat, .ps1)
echo   ✓ test/          (testes.c, teste-som.c)
echo   ✓ bin/           (executáveis)
echo.

echo Próximos passos:
echo   1. git status
echo   2. git add -A
echo   3. git commit -m "chore: reorganizar estrutura do projeto"
echo   4. git push origin develop
echo.

pause
