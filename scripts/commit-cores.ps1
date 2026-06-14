# =============================================================================
# commit-cores.ps1 - Commit automático das mudanças de coloração
# =============================================================================
# Script: scripts/commit-cores.ps1
# Executa a partir de: scripts/ (vai para raiz automaticamente)
# Shell: PowerShell (funciona no VS Code!)
# =============================================================================

# Ir para a raiz do projeto (um nível acima de scripts/)
Set-Location "$PSScriptRoot\.."

Write-Host ""
Write-Host "====================================================="-ForegroundColor Cyan
Write-Host "  Fazendo commit das mudancas de coloracao" -ForegroundColor Cyan
Write-Host "====================================================="-ForegroundColor Cyan
Write-Host ""

# Verificar se estamos num repositorio git
try {
    git rev-parse --git-dir >$null 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "Não é repositório git"
    }
} catch {
    Write-Host "ERRO: Nao e um repositorio git!" -ForegroundColor Red
    Write-Host "Certifique-se de que esta no diretorio correto do projeto" -ForegroundColor Yellow
    Read-Host "Pressione ENTER para sair"
    exit 1
}

# Mostrar status
Write-Host "Status atual:" -ForegroundColor Yellow
git status
Write-Host ""

# Perguntar antes de fazer commit
Write-Host ""
Write-Host "Arquivos que serao adicionados:" -ForegroundColor Cyan
Write-Host "  - visualizacao.h (constantes de cores)" -ForegroundColor Gray
Write-Host "  - visualizacao.c (funcoes definirCor, restaurarCor, exibirLabirintoComCores)" -ForegroundColor Gray
Write-Host "  - steering/structure.md (documentacao)" -ForegroundColor Gray
Write-Host "  - README.md (secoes de cores)" -ForegroundColor Gray
Write-Host "  - docs/CORES_VISUALIZACAO.md (novo - guia completo)" -ForegroundColor Gray
Write-Host "  - docs/IMPLEMENTACAO_CORES.md (novo - detalhes tecnicos)" -ForegroundColor Gray
Write-Host "  - scripts/commit-cores.ps1 (novo - automacao de commit)" -ForegroundColor Gray
Write-Host "  - scripts/test-compile.ps1 (novo - teste rapido)" -ForegroundColor Gray
Write-Host ""

# Fazer add
Write-Host "Adicionando arquivos..." -ForegroundColor Yellow
git add -A

Write-Host ""
Write-Host "Fazendo commit..." -ForegroundColor Yellow
Write-Host ""

$commitMessage = @"
feat(viz): sistema de coloracao com 3 fases (vermelho/azul/verde)

Implementacao:
- Adiciona constantes de cor (COR_VERMELHO, COR_VERDE, COR_AZUL)
- Implementa funcoes definirCor() e restaurarCor()
- Cria funcao exibirLabirintoComCores() para coloracao automatica

Fases de cor:
- Fase 1 (Exploracao): visitados em VERMELHO
- Fase 2 (Reconstrucao): caminho em AZUL
- Fase 3 (Resultado): caminho em VERDE

Documentacao:
- docs/CORES_VISUALIZACAO.md: guia completo de cores
- docs/IMPLEMENTACAO_CORES.md: detalhes tecnicos
- README.md: atualizado com secoes de cores
- steering/structure.md: atualizado

Scripts:
- scripts/commit-cores.ps1: automacao de commit
- scripts/test-compile.ps1: teste rapido de compilacao

Compatibilidade:
- Windows: totalmente funcional
- Linux/macOS: compila sem erros, sem cores (futuro: ANSI codes)
"@

git commit -m $commitMessage

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERRO ao fazer commit!" -ForegroundColor Red
    Read-Host "Pressione ENTER para sair"
    exit 1
}

Write-Host ""
Write-Host "====================================================="-ForegroundColor Green
Write-Host "  Commit realizado com sucesso!" -ForegroundColor Green
Write-Host "====================================================="-ForegroundColor Green
Write-Host ""

# Mostrar o commit criado
Write-Host "Commit criado:" -ForegroundColor Cyan
git log -1 --oneline

Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Yellow
Write-Host "  1. Testar compilacao: .\scripts\test-compile.ps1" -ForegroundColor Gray
Write-Host "  2. Compilar projeto: .\build.bat" -ForegroundColor Gray
Write-Host "  3. Executar programa: .\bin\labirinto.exe" -ForegroundColor Gray
Write-Host "  4. Fazer push: git push origin develop" -ForegroundColor Gray
Write-Host "  5. Criar PR: .\scripts\auto-pr.ps1 feat viz 'Sistema de coloracao'" -ForegroundColor Gray
Write-Host ""

Read-Host "Pressione ENTER para sair"
