@echo off
REM ==========================================================================
REM build.bat - Compila o programa e os testes (Windows + MinGW/gcc)
REM Executaveis sao colocados em bin/
REM Testes sao compilados a partir de test/
REM ==========================================================================

REM Criar pasta bin se nao existir
if not exist "bin" mkdir bin

echo === Compilando o PROGRAMA (com animacao + audio) ===
gcc -Wall labirinto.c visualizacao.c main.c -o bin\labirinto.exe
if errorlevel 1 goto erro

echo === Compilando os TESTES (C ANSI puro: -ansi -pedantic) ===
gcc -ansi -pedantic -Wall labirinto.c test\testes.c -o bin\testes.exe
if errorlevel 1 goto erro

echo === Compilando teste de AUDIO ===
gcc -Wall test\teste-som.c -o bin\teste-som.exe
if errorlevel 1 goto erro

echo.
echo ==========================================
echo  Compilacao concluida com sucesso!
echo ==========================================
echo  Programa : bin\labirinto.exe
echo  Testes   : bin\testes.exe
echo  Teste Audio : bin\teste-som.exe
echo.
echo  Dica: rode os testes antes de apresentar:  bin\testes.exe
goto fim

:erro
echo.
echo *** FALHA NA COMPILACAO. Verifique as mensagens acima. ***

:fim
