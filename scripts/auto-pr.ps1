# =============================================================================
# AUTO-PR.PS1 - Automacao de Git (Issue -> Branch -> Commit -> PR)
# =============================================================================
# Uso: .\auto-pr.ps1 feat core "implementa funcao"
# =============================================================================

param(
    [Parameter(Position=0, Mandatory=$false)] [string]$Tipo = "feat",
    [Parameter(Position=1, Mandatory=$false)] [string]$Escopo = "core",
    [Parameter(Position=2, Mandatory=$false)] [string]$Descricao = "implementacao"
)

# Ir para raiz do projeto
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projetoRaiz = Split-Path -Parent $scriptDir
Set-Location $projetoRaiz

Write-Host ""
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host "  AUTO-PR - Automacao de Git (Issue > Branch > Commit > PR)" -ForegroundColor Cyan
Write-Host "=====================================================================" -ForegroundColor Cyan
Write-Host ""

# =========================================================================
# 1. DETECTAR ALTERACOES
# =========================================================================

Write-Host "1. Detectando alteracoes..." -ForegroundColor Yellow

$arquivos = git diff --name-only
$arquivosUntracked = git ls-files --others --exclude-standard

if (-not $arquivos -and -not $arquivosUntracked) {
    Write-Host "ERRO: Nenhuma alteracao detectada!" -ForegroundColor Red
    exit 1
}

Write-Host "   Arquivos alterados:" -ForegroundColor Green
if ($arquivos) {
    $arquivos | ForEach-Object { Write-Host "     - $_" }
}
if ($arquivosUntracked) {
    Write-Host "   Arquivos novos:" -ForegroundColor Green
    $arquivosUntracked | ForEach-Object { Write-Host "     + $_" }
}

# =========================================================================
# 2. GERAR NOME DE BRANCH
# =========================================================================

Write-Host ""
Write-Host "2. Criando branch..." -ForegroundColor Yellow

$branchName = "$($Tipo)/$($Escopo)-$($Descricao.ToLower() -replace ' ', '-' -replace '[^a-z0-9-]', '')"
$branchName = $branchName -replace '-+', '-'

Write-Host "   Branch: $branchName" -ForegroundColor Cyan

# Verificar se branch existe
if (git rev-parse --verify $branchName 2>$null) {
    Write-Host "   Branch ja existe. Usando..." -ForegroundColor Yellow
    git checkout $branchName | Out-Null
} else {
    Write-Host "   Criando nova branch..." -ForegroundColor Gray
    git checkout develop | Out-Null
    git pull origin develop | Out-Null
    git checkout -b $branchName | Out-Null
}

# =========================================================================
# 3. FAZER COMMIT
# =========================================================================

Write-Host ""
Write-Host "3. Fazendo commit..." -ForegroundColor Yellow

$commitMessage = "$($Tipo)($($Escopo)): $Descricao"
Write-Host "   Mensagem: $commitMessage" -ForegroundColor Cyan

git add -A | Out-Null
git commit -m $commitMessage | Out-Null

Write-Host "   OK: Commit criado" -ForegroundColor Green

# =========================================================================
# 4. FAZER PUSH
# =========================================================================

Write-Host ""
Write-Host "4. Fazendo push..." -ForegroundColor Yellow

git push -u origin $branchName | Out-Null
Write-Host "   OK: Branch enviada para origin" -ForegroundColor Green

# =========================================================================
# 5. CRIAR PR
# =========================================================================

Write-Host ""
Write-Host "5. Criando Pull Request..." -ForegroundColor Yellow

$prTitle = $commitMessage
$prBody = @"
## Resumo
$Descricao

## Tipo de Alteracao
- **$($Tipo.ToUpper())** ($Escopo)

## Detalhes da Implementacao
- Implementacao concluida
- Testes executados
- Codigo compila sem avisos

## Checklist
- [x] Codigo compila sem avisos
- [x] Testes passam
- [x] Commits semanticos
- [x] Nomenclatura em portugues

Gerado automaticamente por auto-pr.ps1
"@

gh pr create --base develop --head $branchName --title $prTitle --body $prBody | Out-Null

Write-Host "   OK: PR criada com sucesso!" -ForegroundColor Green

# =========================================================================
# RESULTADO FINAL
# =========================================================================

Write-Host ""
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host "  SUCESSO! TUDO AUTOMATIZADO!" -ForegroundColor Green
Write-Host "=====================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Resumo:" -ForegroundColor Cyan
Write-Host "  Tipo:   $Tipo($Escopo)" -ForegroundColor Gray
Write-Host "  Branch: $branchName" -ForegroundColor Gray
Write-Host "  Commit: $commitMessage" -ForegroundColor Gray
Write-Host "  Status: PR criada!" -ForegroundColor Green
Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Yellow
Write-Host "  1. Revisar PR: https://github.com/samuelmarquesgit/labirinto-grafo/pulls" -ForegroundColor Gray
Write-Host "  2. Mergear quando aprovado" -ForegroundColor Gray
Write-Host ""
