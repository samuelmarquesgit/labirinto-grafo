@echo off
REM Remove arquivos .bat da raiz (que estão no lugar errado)

cd /d "%~dp0"

echo Removendo arquivos .bat da raiz...
if exist commit-cores.bat del /f /q commit-cores.bat && echo  ✓ commit-cores.bat deletado
if exist test-compile.bat del /f /q test-compile.bat && echo  ✓ test-compile.bat deletado

echo.
echo Arquivos .bat movidos para: \scripts
echo.
pause
