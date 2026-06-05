# 📜 BATCH SCRIPTS ARCHIVE — Todos os Scripts .BAT

Documentação completa de todos os scripts **Batch** (`.bat`) criados para automação do projeto.

---

## 📋 Índice

1. [Build & Compilação](#build--compilação)
2. [Git & Limpeza](#git--limpeza)
3. [Referência Rápida](#referência-rápida)
4. [Como Usar](#como-usar)

---

## 🔨 Build & Compilação

### `build.bat` — Compilar Programa + Testes
**Localização:** Raiz  
**Versão:** 2.0  
**Atualizado em:** 2026-06-04

**Função:** Compila todo o projeto para executáveis em `bin/`

**O que compila:**
```
labirinto.c + visualizacao.c + main.c → bin/labirinto.exe
labirinto.c + test/testes.c → bin/testes.exe
test/teste-som.c → bin/teste-som.exe
```

**Alterações em 2026-06-04:**
- Cria pasta `bin/` automaticamente se não existir
- Coloca todos os executáveis em `bin/`
- Compila testes usando `test/testes.c` (novo caminho)
- Compila teste-som usando `test/teste-som.c`

**Como usar:**
```cmd
build.bat
```

**Esperado:**
```
=== Compilando o PROGRAMA (com animacao + audio) ===
=== Compilando os TESTES (C ANSI puro: -ansi -pedantic) ===
=== Compilando teste de AUDIO ===

==========================================
 Compilacao concluida com sucesso!
==========================================
 Programa : bin\labirinto.exe
 Testes   : bin\testes.exe
 Teste Audio : bin\teste-som.exe
```

**Compiladores usados:**
- Para programa: `gcc -Wall labirinto.c visualizacao.c main.c -o bin\labirinto.exe`
- Para testes: `gcc -ansi -pedantic -Wall labirinto.c test\testes.c -o bin\testes.exe`
- Para teste-som: `gcc -Wall test\teste-som.c -o bin\teste-som.exe`

---

## 🔀 Git & Limpeza

### `test/run-tests.bat` — Executar Testes
**Localização:** test/  
**Versão:** 1.0  
**Criado em:** 2026-06-04

**Função:** Compila (se necessário) e executa testes unitários

**O que faz:**
1. Verifica se `bin/testes.exe` existe
2. Se não existir, executa `build.bat` automaticamente
3. Executa `bin/testes.exe`
4. Retorna código de erro apropriado (0 = sucesso, 1 = falha)

**Como usar:**
```cmd
test\run-tests.bat
```

**Esperado:**
```
============================================
 Executando Testes de Unidade
============================================

OK - TODOS OS TESTES PASSARAM!
============================================
```

**Script:**
```batch
@echo off
REM Volta para raiz
cd /d "%~dp0.."

if not exist "bin\testes.exe" (
    echo ERRO: bin\testes.exe nao encontrado!
    echo Por favor, compile primeiro com: build.bat
    exit /b 1
)

REM Executar testes
bin\testes.exe
set test_result=%errorlevel%

if %test_result% equ 0 (
    echo OK - TODOS OS TESTES PASSARAM!
) else (
    echo ERRO - ALGUNS TESTES FALHARAM!
)
```

---

### `scripts/limpar-branches.bat` — Limpar Branches Git
**Localização:** scripts/  
**Versão:** 1.0  
**Criado em:** 2026-06-04

**Função:** Remove branches locais e remotas que conflitam

**O que deleta:**
```
Local:
  - feature/bfs-algorithm
  - feature/dijkstra-algorithm
  - feature/visualization
  - feature/audio-threading
  - feature/main-menu

Remoto (origin):
  - feature/bfs-algorithm
  - feature/dijkstra-algorithm
  - feature/visualization
  - feature/audio-threading
  - feature/main-menu
```

**Como usar:**
```cmd
scripts\limpar-branches.bat
```

**Quando usar:**
- Antes de rodar scripts de PR automáticas
- Quando há conflito de branches existentes
- Para "resetar" o repositório local

---

### `scripts/limpar-projeto.bat` — Limpeza Geral do Projeto
**Localização:** scripts/  
**Versão:** 1.0  
**Criado em:** 2026-06-04

**Função:** Remove arquivos e pastas desnecessários (alternativa a LIMPAR.ps1)

**O que deleta:**
- ESTRUTURA_DO_PROJETO.md
- ESTRUTURA_CRIADA.txt
- ESTRUTURA_VISUAL.txt
- ESTRUTURA_FINAL.txt
- COMECE_AQUI.txt
- README_NOVO_PROJETO.md
- criar-issues.ps1
- criar-prs.bat, criar-prs.ps1, criar-prs.sh
- executar-prs.bat
- Pastas .pr-bodies (em raiz e scripts/)
- Scripts antigos em scripts/

**Como usar:**
```cmd
scripts\limpar-projeto.bat
```

**Nota:** Versão CMD de `LIMPAR.ps1`

---

### `scripts/executar-prs-v2.bat` — Criar 5 PRs Automáticas
**Localização:** scripts/  
**Versão:** 2.0  
**Criado em:** 2026-06-04

**Função:** Cria automaticamente 5 PRs com commits vazios

**Cria:**
1. `feature/bfs-algorithm` → Issue #6
2. `feature/dijkstra-algorithm` → Issue #9
3. `feature/visualization` → Issue #10
4. `feature/audio-threading` → Issue #11
5. `feature/main-menu` → Issue #12

**Fluxo para cada PR:**
```batch
git checkout develop
git pull origin develop
git checkout -b feature/xxx
git commit --allow-empty -m "feat(...): descrição"
git push -u origin feature/xxx
gh pr create --base develop --head feature/xxx --title "..." --body-file "scripts\.pr-bodies\xxx.txt"
```

**Como usar:**
```cmd
scripts\executar-prs-v2.bat
```

**Pré-requisitos:**
- Git instalado
- GitHub CLI (`gh`) instalado e autenticado
- Branches limpas (rodar `scripts\limpar-branches.bat` antes, se necessário)

**Esperado:**
```
===============================================
Tarefa: Issue #6 - BFS
===============================================
...
OK - PR #? (BFS) criado com sucesso!
```

---

## 📊 Referência Rápida

### Scripts de Build (Executar antes de tudo)
| Script | Finalidade | Quando usar |
|--------|-----------|-----------|
| `build.bat` | Compila tudo | Após editar código `.c/.h` |
| `test\run-tests.bat` | Roda testes | Para validar lógica |

### Scripts de Git (Setup inicial)
| Script | Finalidade | Quando usar |
|--------|-----------|-----------|
| `scripts\limpar-branches.bat` | Remove branches antigas | Antes de `executar-prs-v2.bat` |
| `scripts\executar-prs-v2.bat` | Cria 5 PRs | Primeira vez para setup |

### Scripts de Limpeza (Ao final)
| Script | Finalidade | Quando usar |
|--------|-----------|-----------|
| `scripts\limpar-projeto.bat` | Remove temporários | Após merge de documentação |
| `LIMPAR.ps1` (PowerShell) | Remove temporários | Alternativa a limpar-projeto.bat |

---

## 🎯 Como Usar

### Primeira Vez (Setup)
```cmd
REM 1. Limpar branches antigas (se houver)
scripts\limpar-branches.bat

REM 2. Compilar
build.bat

REM 3. Rodar testes
test\run-tests.bat

REM 4. Criar PRs automáticas
scripts\executar-prs-v2.bat

REM 5. Limpeza final
scripts\limpar-projeto.bat
```

### Durante Desenvolvimento (Rotina)
```cmd
REM Após editar código:
build.bat
test\run-tests.bat

REM Se tudo passou, fazer commit:
git add arquivo.c
git commit -m "feat(core): descrição"
git push
```

---

## 📝 Detalhes Técnicos

### `build.bat` — Código Completo
```batch
@echo off
REM Cria pasta bin se não existir
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
goto fim

:erro
echo *** FALHA NA COMPILACAO ***

:fim
```

### `test/run-tests.bat` — Código Completo
```batch
@echo off
cd /d "%~dp0.."

echo ============================================
echo  Executando Testes de Unidade
echo ============================================
echo.

if not exist "bin\testes.exe" (
    echo ERRO: bin\testes.exe nao encontrado!
    echo Por favor, compile primeiro com: build.bat
    echo.
    pause
    exit /b 1
)

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
```

---

## ✅ Status de Cada Script

| Script | Status | Descrição |
|--------|--------|-----------|
| `build.bat` | ✅ Ativo | Essencial - manter sempre |
| `test/run-tests.bat` | ✅ Ativo | Essencial - manter sempre |
| `scripts/executar-prs-v2.bat` | ⚠️ Temporário | Use para setup inicial |
| `scripts/limpar-branches.bat` | ⚠️ Temporário | Use quando necessário |
| `scripts/limpar-projeto.bat` | ⚠️ Temporário | Use após merge de docs |

---

## 🔗 Documentação Relacionada

- `SCRIPTS_ARCHIVE.md` — Todos os scripts (.ps1, .sh, .bat)
- `scripts/README.md` — Documentação de scripts
- `docs/branching-strategy.md` — Estratégia de branches
- `steering/structure.md` — Estrutura do projeto

---

**Última atualização:** 2026-06-05  
**Versão:** 1.0
