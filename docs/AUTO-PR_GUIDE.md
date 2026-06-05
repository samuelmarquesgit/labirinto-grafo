# 🤖 AUTO-PR — Guia de Uso

Script PowerShell que **automatiza o fluxo completo de Git**: detecta alterações, cria branch, commit e PR com descrição dinâmica.

---

## 🚀 Uso Rápido

```powershell
cd scripts
.\auto-pr.ps1 feat core "implementa funcao resolverLabirinto"
```

---

## 📖 Sintaxe Completa

```powershell
.\auto-pr.ps1 [tipo] [escopo] ["descrição"]
```

### Parâmetros

| Parâmetro | Obrigatório? | Descrição | Exemplo |
|-----------|-------------|-----------|---------|
| `tipo` | Não | feat, fix, docs, test, refactor | `feat` |
| `escopo` | Não | core, algo, viz, test, docs, build | `core` |
| `descrição` | Não | O que foi feito (será convertido para branch-name) | `"implementa resolverLabirinto"` |

---

## ✨ O Que O Script Faz

### 1️⃣ Detecta Alterações
```
📊 Analisa git diff
✅ Encontra arquivos modificados
✅ Encontra arquivos novos (untracked)
```

### 2️⃣ Detecta Tipo Automaticamente
```
Se alterou *.md  →  tipo = docs
Se alterou test  →  tipo = test
Se alterou visualizacao  →  tipo = feat (escopo = viz)
Senão  →  usa o tipo especificado
```

### 3️⃣ Cria Branch Semântica
```
Formato: [tipo]/[escopo]-[descrição]
Exemplo: feat/core-implementa-resolverLabirinto
```

### 4️⃣ Faz Commit Semântico
```
Mensagem: feat(core): implementa funcao resolverLabirinto
Corpo: Lista de arquivos alterados/novos
```

### 5️⃣ Faz Push da Branch
```
git push -u origin feature/xxx
```

### 6️⃣ Gera Descrição de PR Dinamicamente
```
✅ Detecta tipo de alteração
✅ Lista arquivos modificados
✅ Gera checklist automático
✅ Inclui emoji de geração automática
```

### 7️⃣ Cria PR Automaticamente
```
gh pr create \
    --base develop \
    --head feature/xxx \
    --title "feat(core): ..." \
    --body "[descrição completa com detalhes das alterações]"
```

---

## 📋 Exemplos de Uso

### Exemplo 1: Implementação Nova (Automático)
```powershell
# Você editou labirinto.c para adicionar resolverDijkstra
# O script detecta automaticamente como "feat"

.\auto-pr.ps1
# ou mais específico:
.\auto-pr.ps1 feat algo "implementa resolverDijkstra"
```

**Resultado:**
- Branch: `feat/algo-implementa-resolverDijkstra`
- Commit: `feat(algo): implementa resolverDijkstra`
- PR criada com descrição automática

---

### Exemplo 2: Correção de Bug
```powershell
# Você corrigiu um bug em visualizacao.c

.\auto-pr.ps1 fix viz "corrige audio picotado"
```

**Resultado:**
- Branch: `fix/viz-corrige-audio-picotado`
- Commit: `fix(viz): corrige audio picotado`
- PR com detalhes da correção

---

### Exemplo 3: Documentação
```powershell
# Você atualizou docs/documento-entrega.md

.\auto-pr.ps1 docs entrega "adiciona screenshots"
```

**Resultado:**
- Branch: `docs/entrega-adiciona-screenshots`
- Commit: `docs(entrega): adiciona screenshots`
- PR automática documentada

---

### Exemplo 4: Teste Novo
```powershell
# Você criou um novo teste em test/testes.c

.\auto-pr.ps1 test algo "testes para dijkstra"
```

**Resultado:**
- Branch: `test/algo-testes-para-dijkstra`
- Commit: `test(algo): testes para dijkstra`
- PR listando os novos testes

---

## 🎯 Tipos de Commit (Conventional Commits)

| Tipo | Uso | Exemplo |
|------|-----|---------|
| `feat` | Nova funcionalidade | `feat(core): implementa resolverLabirinto` |
| `fix` | Correção de bug | `fix(viz): corrige audio picotado` |
| `docs` | Documentação | `docs(entrega): adiciona screenshots` |
| `test` | Testes | `test(algo): testes para dijkstra` |
| `refactor` | Refatoração | `refactor(core): reorganiza codigo` |
| `style` | Formatação | `style(core): ajusta indentacao` |
| `chore` | Tarefas auxiliares | `chore(build): atualiza build.bat` |

---

## 📍 Escopos (Conventional Commits)

| Escopo | Módulo | Exemplo |
|--------|--------|---------|
| `core` | labirinto.c/.h | `feat(core): implementa struct` |
| `algo` | Algoritmos (BFS, Dijkstra) | `feat(algo): implementa dijkstra` |
| `viz` | Visualização/Áudio | `feat(viz): implementa animacao` |
| `test` | Testes | `test(test): adiciona 3 testes` |
| `docs` | Documentação | `docs(docs): preenche template` |
| `build` | Build/Compilação | `fix(build): atualiza paths` |

---

## ✅ Fluxo Completo Automatizado

### Antes (Manual)
```bash
# 1. Criar issue manualmente no GitHub
# 2. Criar branch manualmente
git checkout -b feature/xxx
# 3. Fazer commit manualmente
git add arquivo.c
git commit -m "..."
# 4. Fazer push manualmente
git push -u origin feature/xxx
# 5. Criar PR manualmente no GitHub
# 6. Preencher descrição manualmente
```

### Agora (Com Auto-PR)
```powershell
.\auto-pr.ps1 feat core "implementa funcao"
# Pronto! Tudo automático em segundos
```

---

## 🔍 O Script Detecta Automaticamente

### 1. **Tipo de Alteração**
```powershell
# Você editou documento.md
.\auto-pr.ps1
# → Detecta como "docs" automaticamente

# Você editou visualizacao.c
.\auto-pr.ps1
# → Detecta como "feat(viz)" automaticamente
```

### 2. **Arquivos Alterados**
```
✅ Detecta modificações (git diff)
✅ Detecta novos arquivos (git ls-files --others)
✅ Lista ambos na PR
```

### 3. **Linhas Adicionadas/Removidas**
```
📊 Analisa diff e conta:
   - Linhas adicionadas
   - Linhas removidas
```

---

## 🛡️ Tratamento de Erros

### Nenhuma alteração detectada
```
❌ Nenhuma alteração detectada!
Solução: Edite arquivo(s) antes de rodar o script
```

### Branch já existe
```
⚠️ Branch já existe. Usando...
✅ Faz checkout da branch existente
```

### Erro ao criar branch
```
❌ Erro ao criar branch!
Solução: Verifique se está em develop e sincronizado
```

### Erro ao criar commit
```
❌ Erro ao criar commit!
Solução: Verifique se arquivos estão stage
```

### Erro ao fazer push
```
❌ Erro ao fazer push!
Solução: Verifique se tem acesso ao repositório
```

### Erro ao criar PR
```
❌ Erro ao criar PR!
Mensagem: Você pode criar manualmente com:
gh pr create --base develop --head feature/xxx ...
```

---

## 🔐 Pré-requisitos

✅ Git instalado  
✅ GitHub CLI (`gh`) instalado e autenticado  
✅ PowerShell 5.1+  
✅ Estar em um repositório Git  
✅ Ter acesso ao repositório no GitHub  

**Verificar:**
```powershell
git --version
gh auth status
```

---

## 📊 Exemplo de PR Gerada Automaticamente

### Título
```
feat(algo): implementa resolverDijkstra
```

### Corpo
```markdown
## Resumo
implementa resolverDijkstra

## Tipo de Alteração
- **FEAT** (algo)

## Arquivos Alterados

### Modificados
- `labirinto.c`
- `labirinto.h`

### Novos
+ `test/teste-dijkstra.c`

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
```

---

## 🎯 Casos de Uso

### Desenvolvimento Rápido
```powershell
# Editar código
# Depois rodar:
.\auto-pr.ps1 feat core "nova feature"
# Pronto! PR criada
```

### Correção de Bugs
```powershell
.\auto-pr.ps1 fix viz "bug no audio"
# PR criada automaticamente
```

### Atualização de Docs
```powershell
.\auto-pr.ps1 docs entrega "screenshots"
# PR em documentação
```

### Refatoração
```powershell
.\auto-pr.ps1 refactor core "reorganiza codigo"
# PR de refatoração
```

---

## 🔗 Referências

- `SCRIPTS_ARCHIVE.md` — Todos os scripts
- `BATCH_SCRIPTS_ARCHIVE.md` — Scripts .bat
- `docs/branching-strategy.md` — Estratégia de branches
- `docs/quick-start-branching.md` — Git manual

---

**Última atualização:** 2026-06-05  
**Versão:** 1.0  
**Status:** ✅ Pronto para uso
