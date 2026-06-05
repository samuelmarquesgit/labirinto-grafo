# ✅ CHECKLIST DE LIMPEZA FINAL

**Data:** 2026-06-05  
**Status:** Pronto para executar

---

## 📋 O Que Será Deletado

### ❌ Arquivos Desnecessários (Raiz)

- [ ] `ESTRUTURA_DO_PROJETO.md` — Mesclado em `steering/structure.md` ✓
- [ ] `ESTRUTURA_CRIADA.txt` — Temporário
- [ ] `ESTRUTURA_VISUAL.txt` — Temporário
- [ ] `ESTRUTURA_FINAL.txt` — Temporário
- [ ] `COMECE_AQUI.txt` — Temporário
- [ ] `README_NOVO_PROJETO.md` — Duplicado com `README.md`

### ❌ Scripts Antigos (Raiz)

- [ ] `criar-issues.ps1` — Movido para `scripts/`
- [ ] `criar-prs.bat` — Substituído por `scripts/executar-prs-v2.bat`
- [ ] `criar-prs.ps1` — Movido para `scripts/`
- [ ] `criar-prs.sh` — Movido para `scripts/`
- [ ] `executar-prs.bat` — Substituído por `scripts/executar-prs-v2.bat`

### ❌ Pastas Temporárias

- [ ] `.pr-bodies/` (raiz) — Descritores temporários
- [ ] `scripts/.pr-bodies/` — Descritores temporários

### ❌ Scripts Antigos em `scripts/`

- [ ] `scripts/limpar-branches.bat` — Usado uma vez
- [ ] `scripts/limpar-projeto.bat` — Alternativa ao LIMPAR.ps1
- [ ] `scripts/executar-prs.bat` — Versão 1 (substituída por v2)
- [ ] `scripts/criar-prs.ps1` — Alternativa
- [ ] `scripts/criar-prs.sh` — Alternativa para Bash
- [ ] `scripts/criar-issues.ps1` — Alternativa

---

## ✅ O Que Será Mantido

### ✓ Documentação Oficial

- [x] `README.md` (raiz) — **ÚNICO .md na raiz**
- [x] `Planejamento.md` — Enunciado original
- [x] `docs/` — Toda documentação oficial
- [x] `specs/` — Especificações
- [x] `steering/` — Diretrizes

### ✓ Documentação de Scripts

- [x] `SCRIPTS_ARCHIVE.md` — Todos os scripts (.ps1, .sh, .bat)
- [x] `BATCH_SCRIPTS_ARCHIVE.md` — Documentação dos .bat
- [x] `AGENTS_PLAN.md` — Plano de agentes
- [x] `scripts/README.md` — Documentação de scripts
- [x] `scripts/AUTO-PR_GUIDE.md` — Guia do auto-pr

### ✓ Scripts Essenciais

- [x] `build.bat` — **Essencial**
- [x] `test/run-tests.bat` — **Essencial**
- [x] `scripts/auto-pr.ps1` — **Novo - Automação Git**
- [x] `LIMPAR.ps1` — Script de limpeza

### ✓ Código-Fonte

- [x] `labirinto.c`, `labirinto.h`
- [x] `visualizacao.c`, `visualizacao.h`
- [x] `main.c`
- [x] `test/testes.c`, `test/teste-som.c`
- [x] `.gitignore`

### ✓ Pastas

- [x] `scripts/` — Com README, auto-pr.ps1, AUTO-PR_GUIDE.md
- [x] `bin/` — Executáveis (gerados)
- [x] `test/` — Testes
- [x] `docs/` — Documentação
- [x] `specs/` — Especificações
- [x] `steering/` — Diretrizes
- [x] `.github/` — Configuração GitHub
- [x] `.git/` — Repositório

---

## 🚀 Como Executar a Limpeza

### Opção 1: PowerShell (Recomendado)
```powershell
.\LIMPAR.ps1
```

### Opção 2: Batch
```cmd
scripts\limpar-projeto.bat
```

---

## 📊 Resumo

| Item | Deletar | Manter |
|------|---------|--------|
| Arquivos .md | 6 | ✓ |
| Scripts antigos | 11 | ✓ |
| Pastas temporárias | 2 | ✓ |
| **Total** | **19** | **Essenciais** |

---

## ⚠️ Verificação Pós-Limpeza

Após executar `.\LIMPAR.ps1`, verifique:

```powershell
# Verificar que README.md existe
Test-Path README.md
# Esperado: True

# Verificar que build.bat existe
Test-Path build.bat
# Esperado: True

# Verificar que auto-pr.ps1 existe
Test-Path scripts\auto-pr.ps1
# Esperado: True

# Listar raiz (não deve ter ESTRUTURA_*.md)
Get-ChildItem *.md
# Esperado: Apenas README.md
```

---

## ✅ Checklist Final

- [ ] Executou `.\LIMPAR.ps1`
- [ ] Verificou que README.md existe
- [ ] Verificou que scripts essenciais existem
- [ ] Fez `git status` para confirmar deletados
- [ ] Fez `git add -A` e `git commit -m "chore: limpeza de arquivos temporarios"`
- [ ] Fez `git push origin develop`

---

**Pronto para executar?** ✅

```powershell
.\LIMPAR.ps1
```

