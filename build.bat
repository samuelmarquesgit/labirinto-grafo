@echo off
REM ==========================================================================
REM build.bat - Compila o programa e os testes (Windows + MinGW/gcc)
REM ==========================================================================

echo === Compilando o PROGRAMA (com animacao + audio) ===
gcc -Wall labirinto.c visualizacao.c main.c -o labirinto.exe
if errorlevel 1 goto erro

echo === Compilando os TESTES (C ANSI puro: -ansi -pedantic) ===
gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe
if errorlevel 1 goto erro

echo.
echo ==========================================
echo  Compilacao concluida com sucesso!
echo ==========================================
echo  Programa : labirinto.exe
echo  Testes   : testes.exe
echo.
echo  Dica: rode os testes antes de apresentar:  testes.exe
goto fim

:erro
echo.
echo *** FALHA NA COMPILACAO. Verifique as mensagens acima. ***

:fim
