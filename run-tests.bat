@echo off
REM ==========================================================================
REM run-tests.bat - Compila e roda APENAS os testes (C ANSI puro)
REM ==========================================================================

echo === Compilando os testes (-ansi -pedantic -Wall) ===
gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe
if errorlevel 1 goto erro

echo === Executando os testes ===
echo.
testes.exe
goto fim

:erro
echo.
echo *** FALHA NA COMPILACAO DOS TESTES. ***

:fim
