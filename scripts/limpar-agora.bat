@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                    LIMPEZA FINAL DO PROJETO                   ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

set contador=0

REM Deletar arquivos na raiz
for %%F in (ESTRUTURA_DO_PROJETO.md ESTRUTURA_CRIADA.txt ESTRUTURA_VISUAL.txt ESTRUTURA_FINAL.txt COMECE_AQUI.txt README_NOVO_PROJETO.md criar-issues.ps1 criar-prs.bat criar-prs.ps1 criar-prs.sh executar-prs.bat) do (
    if exist "%%F" (
        del /f /q "%%F" 2>nul
        set /a contador+=1
        echo ✓ Deletado: %%F
    )
)

REM Deletar pastas
echo.
echo Deletando pastas...
if exist ".pr-bodies" (
    rmdir /s /q ".pr-bodies" 2>nul
    set /a contador+=1
    echo ✓ Deletada pasta: .pr-bodies
)

if exist "scripts\.pr-bodies" (
    rmdir /s /q "scripts\.pr-bodies" 2>nul
    set /a contador+=1
    echo ✓ Deletada pasta: scripts\.pr-bodies
)

REM Deletar scripts antigos em scripts/
echo.
echo Deletando scripts antigos em scripts/...
for %%F in (limpar-branches.bat limpar-projeto.bat executar-prs.bat criar-prs.ps1 criar-prs.sh criar-issues.ps1 executar-prs-v2.bat) do (
    if exist "scripts\%%F" (
        del /f /q "scripts\%%F" 2>nul
        set /a contador+=1
        echo ✓ Deletado: scripts\%%F
    )
)

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                    ✅ LIMPEZA CONCLUÍDA!                      ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo Total de arquivos deletados: !contador!
echo.
echo Próximos passos:
echo   1. Verifique: git status
echo   2. Commit: git add -A
echo   3. Commit: git commit -m "chore: limpeza de temporarios"
echo   4. Push: git push origin develop
echo.
pause
