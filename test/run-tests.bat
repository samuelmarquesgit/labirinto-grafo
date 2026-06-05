@echo off
REM =============================================================================
REM run-tests.bat - Executa testes unitarios
REM =============================================================================

cd /d "%~dp0.."

echo.
echo ============================================
echo  Executando Testes de Unidade
echo ============================================
echo.

REM Verificar se bin/testes.exe existe
if not exist "bin\testes.exe" (
    echo ERRO: bin\testes.exe nao encontrado!
    echo Por favor, compile primeiro com: build.bat
    echo.
    pause
    exit /b 1
)

REM Executar testes
bin\testes.exe
set test_result=%errorlevel%

echo.
echo ============================================

if %test_result% equ 0 (
    echo  OK - TODOS OS TESTES PASSARAM!
    echo ============================================
) else (
    echo  ERRO - ALGUNS TESTES FALHARAM!
    echo ============================================
    echo.
    echo  Resultado: %test_result%
)

echo.
pause
