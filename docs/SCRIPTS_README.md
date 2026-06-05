# 📝 Scripts do Projeto Labirinto-Grafo

Pasta contendo todos os scripts de automação do projeto.

## 🎯 Scripts Disponíveis

### 1. `criar-issues.ps1` — Criar Issues Automáticas
Cria as 11 issues restantes do projeto no GitHub.

**Como usar (PowerShell):**
```powershell
cd scripts
.\criar-issues.ps1
```

**Resultado:**
- Cria 11 issues com descrição completa
- Adiciona labels automaticamente (feature, test, docs, urgent)
- Pronto para começar o fluxo de branches

---

### 2. `executar-prs.bat` — Criar PRs Automáticas (Batch)
Cria automaticamente as 5 PRs principais do núcleo.

**Como usar (CMD/PowerShell):**
```cmd
scripts\executar-prs.bat
```

**O que faz:**
1. Cria branch semântica para cada tarefa
2. Faz commit semântico
3. Faz push da branch
4. Cria PR com descrição **completa e detalhada**
5. Usa arquivos em `.pr-bodies/` para as descrições

**Resultado:**
- 5 PRs criadas com checklist completo
- Cada PR referencia a issue correspondente (`Closes #N`)
- Pronto para revisar e mergear

---

### 3. `criar-prs.ps1` — Criar PRs Automáticas (PowerShell)
Versão PowerShell do script de criação de PRs.

**Como usar:**
```powershell
cd scripts
.\criar-prs.ps1
```

**Vantagens:**
- Usa função reutilizável
- Melhor tratamento de cores
- Mais robusto que batch

---

### 4. `criar-prs.sh` — Criar PRs Automáticas (Bash)
Versão Bash para MSYS64/Git Bash.

**Como usar:**
```bash
cd scripts
bash criar-prs.sh
```

---

## 📂 Estrutura de Pastas

```
scripts/
├── README.md                    (este arquivo)
├── executar-prs.bat            (batch - cria 5 PRs)
├── criar-prs.ps1              (PowerShell - cria 5 PRs)
├── criar-prs.sh               (Bash - cria 5 PRs)
├── criar-issues.ps1           (PowerShell - cria 11 issues)
└── .pr-bodies/                (descrições das PRs)
    ├── bfs.txt
    ├── dijkstra.txt
    ├── visualization.txt
    ├── audio.txt
    └── menu.txt
```

## 🔄 Fluxo Recomendado

### Passo 1: Criar Issues
```powershell
.\criar-issues.ps1
```

### Passo 2: Criar PRs Automáticas
Escolha **uma** das opções:

**Opção A: Batch (recomendado para Windows)**
```cmd
.\executar-prs.bat
```

**Opção B: PowerShell**
```powershell
.\criar-prs.ps1
```

**Opção C: Bash (MSYS64)**
```bash
bash criar-prs.sh
```

### Passo 3: Revisar PRs
Acesse: https://github.com/samuelmarquesgit/labirinto-grafo/pulls

### Passo 4: Mergear para Develop
```bash
git checkout develop
git merge feature/bfs-algorithm
git push origin develop
```

### Passo 5: Mergear para Main
Após todos os testes passarem:
```bash
git checkout main
git merge develop
git push origin main
```

## 📋 Checklist de PRs Criadas

Cada PR terá:
- ✅ Título semântico (feat/fix/docs)
- ✅ Descrição completa e detalhada
- ✅ Seção "Contexto" explicando a implementação
- ✅ Seção "Arquivos alterados"
- ✅ Seção "Como testar" com comandos exatos
- ✅ Checklist de Qualidade (10-15 itens)
- ✅ Detalhes técnicos específicos
- ✅ Referência à issue (`Closes #N`)
- ✅ Emoji de geração automática 🤖

## 🚀 Dicas e Truques

### Se o script falhar:
1. Certifique-se de estar na raiz do projeto
2. Verifique se `git` e `gh` estão instalados
3. Verifique se está logado no GitHub: `gh auth status`

### Para fazer login no GitHub:
```bash
gh auth login
```

### Para listar issues criadas:
```bash
gh issue list
```

### Para listar PRs criadas:
```bash
gh pr list
```

---

## 📖 Mais Informações

- 📚 [Branching Strategy](../BRANCHING_STRATEGY.md)
- ⚡ [Quick Start](../QUICK_START_BRANCHING.md)
- 📝 [Estrutura do Projeto](../README.md)

---

**Última atualização:** 2026-06-04  
**Versão:** 1.0.0
