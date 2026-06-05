# Limpeza final - Remove arquivos desnecessários após mesclar informações

$arquivos_deletar = @(
    "ESTRUTURA_DO_PROJETO.md",
    "ESTRUTURA_CRIADA.txt",
    "ESTRUTURA_VISUAL.txt",
    "ESTRUTURA_FINAL.txt",
    "COMECE_AQUI.txt",
    "README_NOVO_PROJETO.md",
    "criar-issues.ps1",
    "criar-prs.bat",
    "criar-prs.ps1",
    "criar-prs.sh",
    "executar-prs.bat",
    "scripts\limpar-branches.bat",
    "scripts\executar-prs.bat",
    "scripts\executar-prs-v2.bat",
    "scripts\criar-prs.ps1",
    "scripts\criar-prs.sh",
    "scripts\criar-issues.ps1",
    "scripts\limpar-projeto.bat"
)

Write-Host "Deletando arquivos desnecessários..." -ForegroundColor Yellow
foreach ($arquivo in $arquivos_deletar) {
    if (Test-Path $arquivo) {
        Remove-Item $arquivo -Force
        Write-Host "✓ Deletado: $arquivo"
    }
}

Write-Host ""
Write-Host "Deletando pastas desnecessárias..." -ForegroundColor Yellow
if (Test-Path ".pr-bodies") {
    Remove-Item ".pr-bodies" -Recurse -Force
    Write-Host "✓ Deletada pasta: .pr-bodies"
}

if (Test-Path "scripts\.pr-bodies") {
    Remove-Item "scripts\.pr-bodies" -Recurse -Force
    Write-Host "✓ Deletada pasta: scripts\.pr-bodies"
}

Write-Host ""
Write-Host "✅ Limpeza concluída!" -ForegroundColor Green
Write-Host ""
Write-Host "Arquivos deletados:" -ForegroundColor Cyan
Write-Host "  - ESTRUTURA*.md (duplicados)"
Write-Host "  - ESTRUTURA*.txt (desnecessários)"
Write-Host "  - COMECE_AQUI.txt"
Write-Host "  - README_NOVO_PROJETO.md"
Write-Host "  - Scripts antigos (criar-*, executar-*)"
Write-Host "  - Pastas .pr-bodies"
Write-Host ""
Write-Host "Mantém:" -ForegroundColor Cyan
Write-Host "  - README.md (raiz)"
Write-Host "  - docs/ (documentação oficial)"
Write-Host "  - specs/ (especificações)"
Write-Host "  - steering/ (diretrizes)"
Write-Host "  - scripts/ (scripts necessários)"
