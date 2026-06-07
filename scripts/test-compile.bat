@echo off
REM =============================================================================
REM Teste rápido de compilação de cores
REM Script: scripts/test-compile.bat
REM Executa a partir de: scripts/ (vai para raiz automaticamente)
REM =============================================================================

REM Ir para a raiz do projeto (um nível acima de scripts/)
cd /d "%~dp0.."

echo.
echo ====================================
echo  Teste de Compilacao (Cores)
echo ====================================
echo.

REM Verificar se estamos num repositorio git
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
    echo AVISO: Nao parece ser um repositorio git
    echo Continuando mesmo assim...
    echo.
)

REM Mostrar ambiente
echo Diretório atual: %cd%
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
gcc --version | findstr "gcc"
echo.

REM Compilar apenas para verificar erros (sem gerar .exe)
echo Verificando sintaxe de visualizacao.c...
echo.
gcc -Wall -c visualizacao.c -o visualizacao.o 2>compile-error.txt

if errorlevel 1 (
    echo.
    echo ====================================
    echo  ERRO NA COMPILACAO!
    echo ====================================
    echo.
    echo Detalhes do erro:
    type compile-error.txt
    echo.
    echo Limpando arquivos temporarios...
    if exist visualizacao.o del /f /q visualizacao.o >nul
    if exist compile-error.txt del /f /q compile-error.txt >nul
    pause
    exit /b 1
)

echo OK - visualizacao.c compila sem erros
echo.

REM Limpeza
if exist visualizacao.o del /f /q visualizacao.o >nul
if exist compile-error.txt del /f /q compile-error.txt >nul

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
