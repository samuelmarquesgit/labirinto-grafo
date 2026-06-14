@echo off
REM =============================================================================
REM Teste rapido de compilacao de cores
REM Script: scripts/test-compile.bat
REM Executa a partir de: scripts/ (vai para raiz automaticamente)
REM Compativel: CMD.exe (se rodar em PowerShell, use test-compile.ps1)
REM =============================================================================

REM Ir para a raiz do projeto (um nível acima de scripts/)
cd /d "%~dp0.."

echo.
echo ====================================
echo  Teste de Compilacao (Cores)
echo ====================================
echo.

REM Verificar se gcc está disponível
gcc --version >nul 2>&1
if errorlevel 1 (
    echo ERRO: gcc nao foi encontrado!
    echo Instale MinGW/gcc e adicione ao PATH
    pause
    exit /b 1
)

echo gcc encontrado:
gcc --version
echo.

echo Verificando sintaxe de visualizacao.c...
echo.

REM Compilar apenas para verificar erros (sem gerar .exe)
gcc -Wall -c visualizacao.c -o visualizacao.o 2>nul

if errorlevel 1 (
    echo.
    echo ====================================
    echo  ERRO NA COMPILACAO!
    echo ====================================
    echo.
    echo Verifique a saida de erro acima.
    echo.
    echo Limpando arquivos temporarios...
    if exist visualizacao.o del /f /q visualizacao.o >nul

    pause
    exit /b 1
)

echo OK - visualizacao.c compila sem erros
echo.

REM Limpeza
if exist visualizacao.o del /f /q visualizacao.o >nul

echo.
echo ====================================
echo  Compilacao Concluida com Sucesso!
echo ====================================
echo.
echo Proximos passos:
echo  1. Compilar projeto: .\build.bat
echo  2. Executar programa: .\bin\labirinto.exe
echo  3. Testar cores nas 3 fases
echo.

pause
