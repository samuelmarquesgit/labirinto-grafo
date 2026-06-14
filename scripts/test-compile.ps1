# =============================================================================
# test-compile.ps1 - Teste rápido de compilação
# =============================================================================
# Script: scripts/test-compile.ps1
# Executa a partir de: scripts/ (vai para raiz automaticamente)
# Shell: PowerShell (funciona no VS Code!)
# =============================================================================

# Ir para a raiz do projeto (um nível acima de scripts/)
Set-Location "$PSScriptRoot\.."

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "  Teste de Compilacao (Cores)" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se gcc está disponível
try {
    $gccVersion = gcc --version 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "gcc não encontrado"
    }
} catch {
    Write-Host "ERRO: gcc nao foi encontrado!" -ForegroundColor Red
    Write-Host "Instale MinGW/gcc e adicione ao PATH" -ForegroundColor Yellow
    Read-Host "Pressione ENTER para sair"
    exit 1
}

Write-Host "gcc encontrado:" -ForegroundColor Green
gcc --version | Select-Object -First 1
Write-Host ""

Write-Host "Verificando sintaxe de visualizacao.c..." -ForegroundColor Yellow
Write-Host ""

# Compilar apenas para verificar erros (sem gerar .exe)
gcc -Wall -c visualizacao.c -o visualizacao.o 2>&1 | Tee-Object -Variable compileOutput

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "====================================" -ForegroundColor Red
    Write-Host "  ERRO NA COMPILACAO!" -ForegroundColor Red
    Write-Host "====================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Detalhes do erro:" -ForegroundColor Yellow
    Write-Host $compileOutput
    Write-Host ""
    Write-Host "Limpando arquivos temporarios..." -ForegroundColor Gray

    if (Test-Path "visualizacao.o") { Remove-Item -Force "visualizacao.o" }

    Read-Host "Pressione ENTER para sair"
    exit 1
}

Write-Host "OK - visualizacao.c compila sem erros" -ForegroundColor Green
Write-Host ""

# Limpeza
if (Test-Path "visualizacao.o") { Remove-Item -Force "visualizacao.o" }

Write-Host ""
Write-Host "====================================" -ForegroundColor Green
Write-Host "  Compilacao Concluida com Sucesso!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Cyan
Write-Host "  1. Compilar projeto: .\build.bat" -ForegroundColor Gray
Write-Host "  2. Executar programa: .\bin\labirinto.exe" -ForegroundColor Gray
Write-Host "  3. Testar cores nas 3 fases" -ForegroundColor Gray
Write-Host ""

Read-Host "Pressione ENTER para sair"
