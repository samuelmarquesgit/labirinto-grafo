# 📜 SCRIPTS ARCHIVE — Todos os Scripts Criados

Documentação de **todos os scripts** desenvolvidos durante o projeto para automação, CI/CD e limpeza.

---

## 📋 Índice

1. [Limpeza & Manutenção](#limpeza--manutenção)
2. [GitHub & Automação](#github--automação)
3. [Build & Compilação](#build--compilação)
4. [Git & Branching](#git--branching)
5. [Como Usar](#como-usar)

---

## 🧹 Limpeza & Manutenção

### `LIMPAR.ps1` — Limpeza Final do Projeto
**Tipo:** PowerShell  
**Localização:** Raiz  
**Propósito:** Remove todos os arquivos desnecessários após merge de documentação

**O que deleta:**
- ESTRUTURA_*.md (duplicados)
- ESTRUTURA_*.txt (temporários)
- COMECE_AQUI.txt
- README_NOVO_PROJETO.md
- Scripts antigos (criar-*.ps1, criar-*.bat, executar-*.bat)
- Pastas .pr-bodies/

**O que mantém:**
- README.md (raiz)
- docs/, specs/, steering/ (documentação oficial)
- scripts/ (scripts necessários)
- Código-fonte (.c, .h, .bat necessários)

**Como usar:**
```powershell
.\LIMPAR.ps1
```

**Criado em:** 2026-06-05  
**Razão:** Consolidar após merge de documentação duplicada

---

### `scripts/limpar-projeto.bat` — Limpeza em Batch
**Tipo:** Batch (CMD)  
**Localização:** scripts/  
**Propósito:** Alternativa em Batch para LIMPAR.ps1

**Como usar:**
```cmd
scripts\limpar-projeto.bat
```

**Status:** Pode ser deletado após usar LIMPAR.ps1

---

### `scripts/limpar-branches.bat` — Limpeza de Branches Git
**Tipo:** Batch (CMD)  
**Localização:** scripts/  
**Propósito:** Limpar branches locais e remotas que conflitam

**Deleta:**
- feature/bfs-algorithm
- feature/dijkstra-algorithm
- feature/visualization
- feature/audio-threading
- feature/main-menu

**Como usar:**
```cmd
scripts\limpar-branches.bat
```

**Status:** Pode ser deletado após usar (foi necessário durante desenvolvimento)

---

## 🚀 GitHub & Automação

### `scripts/criar-issues.ps1` — Criar 11 Issues no GitHub
**Tipo:** PowerShell  
**Localização:** scripts/  
**Propósito:** Automatizar criação de issues no GitHub

**Cria 11 issues:**
- 4 issues de núcleo (BFS, Dijkstra, Visualização, Áudio, Menu)
- 4 issues de testes
- 3 issues de documentação

**Cada issue contém:**
- Título semântico [Feat], [Test], [Docs]
- Descrição detalhada
- Labels automáticas (feature, test, docs, urgent, algo, viz, core)

**Como usar:**
```powershell
cd scripts
.\criar-issues.ps1
```

**Criado em:** 2026-06-04  
**Razão:** Automatizar criação de issues baseadas em especificações do projeto

**Dependências:**
- GitHub CLI (`gh`) instalado
- Autenticado no GitHub (`gh auth login`)

---

### `scripts/executar-prs-v2.bat` — Criar 5 PRs com Commits Vazios
**Tipo:** Batch (CMD)  
**Localização:** scripts/  
**Propósito:** Criar automaticamente 5 PRs do núcleo

**Cria 5 PRs:**
1. feature/bfs-algorithm (Issue #6)
2. feature/dijkstra-algorithm (Issue #9)
3. feature/visualization (Issue #10)
4. feature/audio-threading (Issue #11)
5. feature/main-menu (Issue #12)

**Cada PR contém:**
- Branch semântica
- Commit vazio (allow-empty) com mensagem semântica
- Push para origin
- Corpo da PR com descrição completa

**Como usar:**
```cmd
scripts\executar-prs-v2.bat
```

**Criado em:** 2026-06-04  
**Razão:** Automatizar criação de PRs com descrição detalhada

**Fluxo:**
1. Atualiza develop
2. Cria branch feature/*
3. Faz commit vazio com mensagem semântica
4. Push de branch
5. Cria PR via GitHub CLI com corpo-arquivo

**Dependências:**
- Git instalado
- GitHub CLI (`gh`) instalado e autenticado
- Branches devem estar limpas (ou rodar limpar-branches.bat antes)

---

### `scripts/criar-prs.ps1` — Criar PRs (PowerShell)
**Tipo:** PowerShell  
**Localização:** scripts/  
**Propósito:** Versão PowerShell de criar PRs

**Status:** Alternativa a executar-prs-v2.bat (usar UMA ou outra)

---

### `scripts/criar-prs.sh` — Criar PRs (Bash)
**Tipo:** Bash  
**Localização:** scripts/  
**Propósito:** Versão Bash para MSYS64/Git Bash

**Status:** Alternativa para sistemas com Bash

---

## 🔨 Build & Compilação

### `build.bat` — Compilar Programa + Testes
**Tipo:** Batch (CMD)  
**Localização:** Raiz  
**Propósito:** Compilar todo o projeto

**O que compila:**
- `labirinto.exe` → programa principal
- `testes.exe` → testes unitários (C ANSI)
- `teste-som.exe` → teste isolado de áudio

**Saída:**
- Todos os executáveis em pasta `bin/`

**Como usar:**
```cmd
build.bat
```

**Alterações em 2026-06-04:**
- Agora cria pasta `bin/` se não existir
- Compila testes de `test/testes.c`
- Coloca executáveis em `bin/`

---

### `test/run-tests.bat` — Rodar Testes Unitários
**Tipo:** Batch (CMD)  
**Localização:** test/  
**Propósito:** Compilar (se necessário) e rodar testes

**O que faz:**
1. Verifica se `bin/testes.exe` existe
2. Se não, roda `build.bat`
3. Executa `bin/testes.exe`
4. Retorna código de erro apropriado

**Como usar:**
```cmd
test\run-tests.bat
```

**Criado em:** 2026-06-04  
**Razão:** Simplificar execução de testes

**Esperado:** "TODOS OS TESTES PASSARAM COM SUCESSO!"

---

## 🔀 Git & Branching

### Estratégia de Commits Semânticos

**Formato:**
```
feat(escopo): descrição breve
fix(escopo): descrição breve
test(escopo): descrição breve
docs(escopo): descrição breve
```

**Escopos:**
- `core` — Núcleo (labirinto.c, labirinto.h)
- `algo` — Algoritmos (BFS, Dijkstra)
- `viz` — Visualização e áudio
- `test` — Testes
- `docs` — Documentação
- `build` — Build e compilação

**Branches:**
```
feature/[descrição]  → Nova funcionalidade
test/[descrição]     → Testes
docs/[descrição]     → Documentação
fix/[descrição]      → Correção de bug
```

**Referência:** `docs/branching-strategy.md`

---

## 🎯 Como Usar

### Fluxo Recomendado (Primeira Vez)

```cmd
REM 1. Limpar branches antigas (se necessário)
scripts\limpar-branches.bat

REM 2. Criar as 11 issues
cd scripts
.\criar-issues.ps1

REM 3. Criar as 5 PRs automáticas
.\executar-prs-v2.bat

REM 4. Compilar
cd ..
build.bat

REM 5. Rodar testes
test\run-tests.bat

REM 6. Limpar arquivos desnecessários
.\LIMPAR.ps1
```

---

### Fluxo Durante Desenvolvimento

```cmd
REM Após fazer alterações:
build.bat          REM Compila
test\run-tests.bat REM Testa

REM Para cada feature nova:
git checkout -b feature/minha-feature
REM ... edite código ...
git add arquivo.c
git commit -m "feat(core): descrição"
git push -u origin feature/minha-feature

REM Criar PR manualmente ou com script
gh pr create --base develop --head feature/minha-feature --title "..." --body "..."
```

---

## 📊 Resumo dos Scripts por Tipo

### PowerShell (.ps1)
| Script | Finalidade |
|--------|-----------|
| `LIMPAR.ps1` | Limpeza final (deletar desnecessários) |
| `scripts/criar-issues.ps1` | Criar 11 issues |
| `scripts/criar-prs.ps1` | Criar 5 PRs (alternativa) |

### Batch (.bat)
| Script | Finalidade |
|--------|-----------|
| `build.bat` | Compilar programa + testes |
| `test/run-tests.bat` | Rodar testes unitários |
| `scripts/limpar-projeto.bat` | Limpeza (alternativa ao LIMPAR.ps1) |
| `scripts/limpar-branches.bat` | Limpar branches git conflitantes |
| `scripts/executar-prs-v2.bat` | Criar 5 PRs |

### Bash (.sh)
| Script | Finalidade |
|--------|-----------|
| `scripts/criar-prs.sh` | Criar 5 PRs (alternativa para Bash) |

---

## 🔑 Scripts Essenciais (Manter)

✅ **Manter permanentemente:**
- `build.bat` — Essencial para compilação
- `test/run-tests.bat` — Essencial para testes
- `scripts/README.md` — Documentação

⚠️ **Usar uma vez e depois deletar:**
- `LIMPAR.ps1` — Use para limpeza final
- `scripts/criar-issues.ps1` — Use para criar issues iniciais
- `scripts/executar-prs-v2.bat` — Use para criar PRs iniciais
- `scripts/limpar-branches.bat` — Use se necessário

---

## 📚 Documentação Relacionada

- `scripts/README.md` — Documentação dos scripts
- `docs/branching-strategy.md` — Estratégia de branches
- `docs/quick-start-branching.md` — Quick start de Git
- `steering/structure.md` — Estrutura do projeto

---

## 🚀 Notas de Desenvolvimento

**Data de Criação:** 2026-06-04 — 2026-06-05  
**Versão:** 1.0  
**Status:** ✅ Documentado e Testado

**Scripts testados com:**
- Windows 11 + MinGW/gcc
- Git Bash
- GitHub CLI (gh)
- PowerShell 5.1+

---

**Última atualização:** 2026-06-05
