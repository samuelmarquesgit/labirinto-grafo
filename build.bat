@echo off
REM =============================================================================
REM build.bat - Compila programa e testes
REM =============================================================================
REM Compilacao do projeto labirinto-grafo
REM Estrutura:
REM   - Raiz: labirinto.c, labirinto.h, visualizacao.c, visualizacao.h, main.c
REM   - test/: testes.c, teste-som.c
REM   - bin/: executaveis
REM =============================================================================

REM Garantir que estamos na raiz do projeto
cd /d "%~dp0"

REM Criar pasta bin/ se nao existir
if not exist "bin" mkdir bin

echo.
echo ===================================================
echo   Compilando Labirinto-Grafo
echo ===================================================
echo.

REM Compilar programa principal (com animacao + audio - sem -ansi)
echo [1/3] Compilando programa (labirinto.exe)...
gcc -Wall labirinto.c visualizacao.c main.c -o bin\labirinto.exe
if errorlevel 1 goto erro

REM Compilar testes (C ANSI puro com -ansi -pedantic)
echo [2/3] Compilando testes (testes.exe)...
gcc -ansi -pedantic -Wall labirinto.c test\testes.c -o bin\testes.exe
if errorlevel 1 goto erro

REM Compilar teste de audio isolado
echo [3/3] Compilando teste de audio (teste-som.exe)...
gcc -Wall test\teste-som.c -o bin\teste-som.exe
if errorlevel 1 goto erro

echo.
echo ===================================================
echo   Compilacao Concluida com Sucesso!
echo ===================================================
echo.
echo   Programa : bin\labirinto.exe
echo   Testes   : bin\testes.exe
echo   Teste Audio : bin\teste-som.exe
echo.
echo Dica: rode os testes antes de apresentar:
echo   test\run-tests.bat
echo.
goto fim

:erro
echo.
echo *** FALHA NA COMPILACAO ***
echo Verifique as mensagens de erro acima.
echo.

:fim
