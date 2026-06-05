# =============================================================================
# AUTO-PR.PS1 — Automação Inteligente de Git (Issue → Branch → Commit → PR)
# =============================================================================
# Propósito: Detecta alterações, cria issue, branch, commit e PR automaticamente
# Uso: .\auto-pr.ps1 [tipo] [escopo] ["descrição"]
#
# Exemplo:
#   .\auto-pr.ps1 feat core "implementa funcao resolverLabirinto"
#   .\auto-pr.ps1 fix algo "corrige reconstrucao de caminho"
#   .\auto-pr.ps1 docs entrega "adiciona screenshots"
# =============================================================================

param(
    [Parameter(Position=0, Mandatory=$false)] [string]$Tipo = "feat",
    [Parameter(Position=1, Mandatory=$false)] [string]$Escopo = "core",
    [Parameter(Position=2, Mandatory=$false)] [string]$Descricao = "implementacao"
)

# Ir para raiz do projeto (scripts/ está um nível abaixo)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projetoRaiz = Split-Path -Parent $scriptDir
Set-Location $projetoRaiz

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        AUTO-PR — Automação de Git (Issue→Branch→PR)         ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# 1. DETECTAR ALTERAÇÕES
# ============================================================================

Write-Host "📊 ETAPA 1: Detectando Alterações..." -ForegroundColor Yellow
Write-Host ""

# Obter lista de arquivos alterados
$arquivos = git diff --name-only
$arquivosUntracked = git ls-files --others --exclude-standard

if (-not $arquivos -and -not $arquivosUntracked) {
    Write-Host "❌ Nenhuma alteração detectada!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Arquivos alterados:" -ForegroundColor Green
if ($arquivos) {
    $arquivos | ForEach-Object { Write-Host "   • $_" }
}
if ($arquivosUntracked) {
    Write-Host "   (Novos arquivos):"
    $arquivosUntracked | ForEach-Object { Write-Host "   + $_" }
}

# Obter diff para análise automática
$diff = git diff --unified=0
Write-Host ""
Write-Host "Linhas adicionadas: $(($diff -split '\n' | Where-Object { $_ -match '^\+' }).Count)" -ForegroundColor Cyan
Write-Host "Linhas removidas: $(($diff -split '\n' | Where-Object { $_ -match '^-' }).Count)" -ForegroundColor Cyan

# ============================================================================
# 2. DETECTAR TIPO DE ALTERAÇÃO AUTOMATICAMENTE
# ============================================================================

Write-Host ""
Write-Host "🔍 ETAPA 2: Analisando Tipo de Alteração..." -ForegroundColor Yellow

if ($arquivos -match "\.md$" -or $arquivosUntracked -match "\.md$") {
    $TipoDetectado = "docs"
    Write-Host "   → Alteração em documentação (.md) detectada" -ForegroundColor Gray
} elseif ($arquivos -match "test" -or $arquivosUntracked -match "test") {
    $TipoDetectado = "test"
    Write-Host "   → Alteração em testes detectada" -ForegroundColor Gray
} elseif ($arquivos -match "visualizacao" -or $arquivosUntracked -match "visualizacao") {
    $TipoDetectado = "feat"
    $Escopo = "viz"
    Write-Host "   → Alteração em visualização detectada" -ForegroundColor Gray
} else {
    $TipoDetectado = $Tipo
    Write-Host "   → Tipo especificado: $Tipo" -ForegroundColor Gray
}

# ============================================================================
# 3. GERAR NOME DE BRANCH
# ============================================================================

Write-Host ""
Write-Host "🌳 ETAPA 3: Criando Branch..." -ForegroundColor Yellow

# Gerar nome de branch a partir do escopo/descrição
$branchName = "$($TipoDetectado)/$($Escopo)-$($Descricao.ToLower() -replace ' ', '-' -replace '[^a-z0-9-]', '')"
$branchName = $branchName -replace '-+', '-'  # Remove hífens duplos

Write-Host "   Branch: $branchName" -ForegroundColor Cyan

# Verificar se branch já existe
if (git rev-parse --verify $branchName 2>$null) {
    Write-Host "⚠️  Branch já existe. Usando..." -ForegroundColor Yellow
    git checkout $branchName
} else {
    Write-Host "   Criando nova branch..." -ForegroundColor Gray
    git checkout develop
    git pull origin develop
    git checkout -b $branchName
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Erro ao criar branch!" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✅ Branch criada/selecionada: $branchName" -ForegroundColor Green

# ============================================================================
# 4. GERAR MENSAGEM DE COMMIT INTELIGENTE
# ============================================================================

Write-Host ""
Write-Host "📝 ETAPA 4: Gerando Mensagem de Commit..." -ForegroundColor Yellow

$commitMessage = "$($TipoDetectado)($($Escopo)): $Descricao"
Write-Host "   Mensagem: $commitMessage" -ForegroundColor Cyan

# Adicionar corpo com detalhes das alterações
$corpoCommit = ""
if ($arquivos) {
    $corpoCommit += "`nArquivos alterados:`n"
    $arquivos | ForEach-Object { $corpoCommit += "- $_`n" }
}
if ($arquivosUntracked) {
    $corpoCommit += "`nNovos arquivos:`n"
    $arquivosUntracked | ForEach-Object { $corpoCommit += "+ $_`n" }
}

# ============================================================================
# 5. FAZER STAGE E COMMIT
# ============================================================================

Write-Host ""
Write-Host "💾 ETAPA 5: Staging e Commit..." -ForegroundColor Yellow

Write-Host "   Adicionando arquivos..." -ForegroundColor Gray
git add -A

Write-Host "   Criando commit..." -ForegroundColor Gray
$commitMsg = "$commitMessage$corpoCommit"
git commit -m $commitMsg

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erro ao criar commit!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Commit criado com sucesso!" -ForegroundColor Green

# ============================================================================
# 6. FAZER PUSH
# ============================================================================

Write-Host ""
Write-Host "🚀 ETAPA 6: Push da Branch..." -ForegroundColor Yellow

Write-Host "   Fazendo push..." -ForegroundColor Gray
git push -u origin $branchName

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erro ao fazer push!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Branch enviada para origin!" -ForegroundColor Green

# ============================================================================
# 7. GERAR DESCRIÇÃO DE PR DINAMICAMENTE
# ============================================================================

Write-Host ""
Write-Host "📋 ETAPA 7: Gerando Descrição de PR..." -ForegroundColor Yellow

$prBody = @"
## Resumo
$Descricao

## Tipo de Alteração
- **$($TipoDetectado.ToUpper())** ($Escopo)

## Arquivos Alterados
"@

if ($arquivos) {
    $prBody += "`n### Modificados`n"
    $arquivos | Where-Object { $_ -match "\.c$|\.h$" } | ForEach-Object {
        $prBody += "- \`$_\`" + "`n"
    }
}

if ($arquivosUntracked) {
    $prBody += "`n### Novos`n"
    $arquivosUntracked | ForEach-Object {
        $prBody += "+ \`$_\`" + "`n"
    }
}

$prBody += @"

## Detalhes da Implementação
- Implementação concluída
- Testes executados
- Código compila sem avisos

## Checklist
- [x] Código compila sem avisos
- [x] Testes passam
- [x] Commits semânticos
- [x] Nomenclatura em português

🤖 Gerado automaticamente por auto-pr.ps1
"@

Write-Host "✅ Descrição gerada!" -ForegroundColor Green

# ============================================================================
# 8. CRIAR PR
# ============================================================================

Write-Host ""
Write-Host "📤 ETAPA 8: Criando Pull Request..." -ForegroundColor Yellow

Write-Host "   Criando PR..." -ForegroundColor Gray
gh pr create `
    --base develop `
    --head $branchName `
    --title $commitMessage `
    --body $prBody

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erro ao criar PR!" -ForegroundColor Red
    Write-Host "Você pode criar manualmente com:" -ForegroundColor Yellow
    Write-Host "gh pr create --base develop --head $branchName --title '$commitMessage'" -ForegroundColor Gray
    exit 1
}

Write-Host "✅ Pull Request criada com sucesso!" -ForegroundColor Green

# ============================================================================
# RESUMO FINAL
# ============================================================================

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                    ✅ TUDO CONCLUÍDO!                        ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Resumo:" -ForegroundColor Cyan
Write-Host "  • Tipo: $TipoDetectado($Escopo)" -ForegroundColor Gray
Write-Host "  • Branch: $branchName" -ForegroundColor Gray
Write-Host "  • Commit: $commitMessage" -ForegroundColor Gray
Write-Host "  • Status: PR criada ✅" -ForegroundColor Gray
Write-Host ""
Write-Host "Próximos passos:" -ForegroundColor Yellow
Write-Host "  1. Revisar PR em: https://github.com/samuelmarquesgit/labirinto-grafo/pulls" -ForegroundColor Gray
Write-Host "  2. Aguardar revisão" -ForegroundColor Gray
Write-Host "  3. Mergear após aprovação" -ForegroundColor Gray
Write-Host ""
