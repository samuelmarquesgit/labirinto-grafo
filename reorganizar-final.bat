@echo off
REM =============================================================================
REM Reorganizacao FINAL - Corrige estrutura e paths
REM =============================================================================

cd /d "%~dp0"

echo.
echo ╔═══════════════════════════════════════════════════════════════╗
echo ║      REORGANIZACAO FINAL - CORRIGINDO ESTRUTURA              ║
echo ╚═══════════════════════════════════════════════════════════════╝
echo.

REM =========================================================================
REM 1. CRIAR BIN/ E MOVER EXECUTAVEIS
REM =========================================================================

echo [1/5] Criando pasta bin/ e movendo executaveis...

if not exist "bin" mkdir bin

REM Mover executáveis de scripts/ para bin/
if exist "scripts\labirinto.exe" move /Y "scripts\labirinto.exe" "bin\" >nul && echo  ✓ labirinto.exe
if exist "scripts\testes.exe" move /Y "scripts\testes.exe" "bin\" >nul && echo  ✓ testes.exe
if exist "scripts\teste-som.exe" move /Y "scripts\teste-som.exe" "bin\" >nul && echo  ✓ teste-som.exe

REM =========================================================================
REM 2. MOVER PLANEJAMENTO.MD PARA RAIZ
REM =========================================================================

echo.
echo [2/5] Movendo Planejamento.md para raiz...

if exist "docs\Planejamento.md" move /Y "docs\Planejamento.md" "." >nul && echo  ✓ Planejamento.md

REM =========================================================================
REM 3. LIMPAR DOCUMENTACAO EM SCRIPTS/
REM =========================================================================

echo.
echo [3/5] Limpando scripts/...

if exist "scripts\AUTO-PR_GUIDE.md" move /Y "scripts\AUTO-PR_GUIDE.md" "docs\" >nul && echo  ✓ AUTO-PR_GUIDE.md → docs/
if exist "scripts\README.md" move /Y "scripts\README.md" "docs\SCRIPTS_README.md" >nul && echo  ✓ README.md → docs/SCRIPTS_README.md

REM =========================================================================
REM 4. CONSOLIDAR DOCUMENTACAO EM DOCS/
REM =========================================================================

echo.
echo [4/5] Consolidando documentacao em docs/...

if exist "AGENTS_PLAN.md" move /Y "AGENTS_PLAN.md" "docs\" >nul && echo  ✓ AGENTS_PLAN.md
if exist "BATCH_SCRIPTS_ARCHIVE.md" move /Y "BATCH_SCRIPTS_ARCHIVE.md" "docs\" >nul && echo  ✓ BATCH_SCRIPTS_ARCHIVE.md
if exist "SCRIPTS_ARCHIVE.md" move /Y "SCRIPTS_ARCHIVE.md" "docs\" >nul && echo  ✓ SCRIPTS_ARCHIVE.md
if exist "LIMPEZA_CHECKLIST.md" move /Y "LIMPEZA_CHECKLIST.md" "docs\" >nul && echo  ✓ LIMPEZA_CHECKLIST.md

REM Deletar duplicatas em docs/
if exist "docs\BRANCHING_STRATEGY.md" del /f /q "docs\BRANCHING_STRATEGY.md" >nul && echo  ✓ Deletada duplicata: BRANCHING_STRATEGY.md
if exist "docs\QUICK_START_BRANCHING.md" del /f /q "docs\QUICK_START_BRANCHING.md" >nul && echo  ✓ Deletada duplicata: QUICK_START_BRANCHING.md
if exist "docs\ISSUES_TO_CREATE.md" del /f /q "docs\ISSUES_TO_CREATE.md" >nul && echo  ✓ Deletada duplicata: ISSUES_TO_CREATE.md

REM =========================================================================
REM 5. LIMPAR SCRIPTS TEMPORARIOS
REM =========================================================================

echo.
echo [5/5] Limpando scripts temporarios...

if exist "reorganizar.bat" del /f /q "reorganizar.bat" >nul && echo  ✓ Deletado: reorganizar.bat
if exist "limpar-agora.bat" del /f /q "limpar-agora.bat" >nul && echo  ✓ Deletado: limpar-agora.bat

if exist "scripts\limpar-branches.bat" del /f /q "scripts\limpar-branches.bat" >nul && echo  ✓ Deletado: scripts\limpar-branches.bat
if exist "scripts\limpar-projeto.bat" del /f /q "scripts\limpar-projeto.bat" >nul && echo  ✓ Deletado: scripts\limpar-projeto.bat

REM =========================================================================
REM RESULTADO
REM =========================================================================

echo.
echo ╔═══════════════════════════════════════════════════════════════╗
echo ║            ✅ REORGANIZACAO CONCLUIDA!                        ║
echo ╚═══════════════════════════════════════════════════════════════╝
echo.

echo ESTRUTURA FINAL:
echo.
echo RAIZ (apenas codigo + build):
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
echo PASTAS:
echo   ✓ bin/           (executaveis: labirinto.exe, testes.exe, teste-som.exe)
echo   ✓ test/          (testes.c, teste-som.c, run-tests.bat)
echo   ✓ scripts/       (auto-pr.ps1, LIMPAR.ps1, etc)
echo   ✓ docs/          (toda documentacao)
echo   ✓ specs/         (especificacoes)
echo   ✓ steering/      (diretrizes)
echo.

echo PROXIMOS PASSOS:
echo   1. git status
echo   2. git add -A
echo   3. git commit -m "chore: reorganizacao final - corrige estrutura"
echo   4. git push origin develop
echo   5. build.bat
echo   6. test\run-tests.bat
echo.

pause
