# ⚡ Quick Start — Branching Semântico

Guia rápido passo a passo para começar a usar branches e commits semânticos neste projeto.

---

## 📋 Exemplo Completo: "Adicionar testes para o Dijkstra"

### Passo 1️⃣: Criar a Issue no GitHub

```bash
gh issue create \
  --title "[Test] Criar testes unitários para o Dijkstra" \
  --body "Adicionar 2 testes para validar:
1. Dijkstra encontra o menor caminho (igual BFS)
2. Dijkstra detecta ausência de caminho

Relacionado com a feature de Dijkstra." \
  --label "test"
```

**Output esperado:**
```
Created issue #5
https://github.com/samuelmarquesgit/labirinto-grafo/issues/5
```

Anote o número: `#5`

---

### Passo 2️⃣: Criar a Branch Semântica

```bash
# Baixe as atualizações da develop
git checkout develop
git pull origin develop

# Crie a branch com nome semântico
git checkout -b test/dijkstra-tests

# Confirme que você está na branch certa
git branch -v
# Output: * test/dijkstra-tests ...
```

---

### Passo 3️⃣: Editar o Código

Edite `testes.c` e adicione os 2 testes do Dijkstra:

```c
/* ----- Teste 7: Dijkstra acha o mesmo menor caminho que a BFS ----- */
static void teste_dijkstra(void) {
    Labirinto lab;
    carregarDoVetor(&lab, MAPA_COM_CAMINHO, 5);

    resolverDijkstra(&lab, &res);

    assert(res.existeCaminho == 1);
    assert(res.passos == 6);
    assert(res.tamanhoCaminho == 7);
    printf("OK - Dijkstra (passos = %d, igual a BFS)\n", res.passos);
}
```

---

### Passo 4️⃣: Commit Semântico

```bash
# Stage os arquivos modificados
git add testes.c

# Faça um commit com mensagem semântica
git commit -m "test(algo): adiciona 2 testes para validar Dijkstra"

# Se quiser ver o log dos commits:
git log --oneline -3
# Output:
# abc1234 test(algo): adiciona 2 testes para validar Dijkstra
# def5678 feat(algo): implementa resolverDijkstra()
# ...
```

---

### Passo 5️⃣: Fazer Push da Branch

```bash
git push -u origin test/dijkstra-tests

# Output:
# Branch 'test/dijkstra-tests' set up to track remote branch 'test/dijkstra-tests' from 'origin'.
```

---

### Passo 6️⃣: Criar o Pull Request

```bash
gh pr create \
  --base develop \
  --head test/dijkstra-tests \
  --title "test(algo): adiciona testes para Dijkstra" \
  --body "Closes #5

## Contexto
Adicionei 2 testes unitários para validar o algoritmo de Dijkstra:
1. Verifica se encontra o menor caminho (igual BFS)
2. Verifica se detecta ausência de caminho

## Arquivos alterados
- testes.c

## Como testar
\`\`\`bash
gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe
testes.exe
\`\`\`

Esperado: 'TODOS OS TESTES PASSARAM COM SUCESSO!'

## Checklist
- [x] Compila sem avisos
- [x] Testes passam
- [x] Mensagens de commit semânticas
- [x] Nomenclatura em português
"
```

**Output esperado:**
```
Created pull request #8
https://github.com/samuelmarquesgit/labirinto-grafo/pull/8
```

---

### Passo 7️⃣: Revisar e Mergear

1. Abra o link do PR no GitHub
2. Espere um membro da equipe revisar
3. Se aprovado, mergeie:

```bash
gh pr merge 8 --merge --delete-branch

# Output:
# ✓ Merged pull request #8 (test/algo: adiciona testes para Dijkstra)
# ✓ Deleted branch test/dijkstra-tests
```

---

## 🎯 Padrão de Nomenclatura Rápido

### Branches

```
feature/[descrição]  → Nova funcionalidade
test/[descrição]     → Testes
docs/[descrição]     → Documentação
fix/[descrição]      → Correção de bug
refactor/[descrição] → Limpeza de código
```

### Commits

```
feat([escopo]): descrição breve
fix([escopo]): descrição breve
docs([escopo]): descrição breve
test([escopo]): descrição breve
refactor([escopo]): descrição breve
style([escopo]): descrição breve
```

### Escopos

```
core  → Núcleo (labirinto.c, labirinto.h)
algo  → Algoritmos (BFS, Dijkstra)
viz   → Visualização e áudio
test  → Testes
docs  → Documentação
build → Build e compilação
```

---

## 🚀 Checklist Antes de Fazer PR

- [ ] Você está na branch correta? (`git branch`)
- [ ] Todos os arquivos foram staged? (`git status`)
- [ ] A mensagem de commit é semântica? (feat/fix/docs/test/...)
- [ ] O código compila sem avisos? (`gcc -ansi -pedantic -Wall ...`)
- [ ] Os testes passam? (`testes.exe`)
- [ ] A issue foi criada antes? (`gh issue create`)
- [ ] O PR fecha a issue? (coloque `Closes #N` no body)

---

## 📚 Referência Rápida de Comandos

```bash
# Criar issue
gh issue create --title "..." --body "..." --label "..."

# Criar branch
git checkout -b feature/nome-da-feature

# Commit semântico
git commit -m "feat(core): descrição breve"

# Push
git push -u origin feature/nome-da-feature

# Criar PR
gh pr create --base develop --head feature/nome-da-feature --title "..." --body "..."

# Mergear PR
gh pr merge [numero] --merge --delete-branch

# Ver status das branches
git branch -v

# Ver commits
git log --oneline -5
```

---

## ❓ Dúvidas Frequentes

**P: E se eu cometi um erro na mensagem do commit?**
R: Para o commit mais recente: `git commit --amend -m "mensagem corrigida"`

**P: Posso fazer múltiplos commits na mesma branch?**
R: Sim! Cada commit semântico = uma mudança lógica. Exemplo:
```bash
git commit -m "feat(core): adiciona funcao A"
git commit -m "feat(core): adiciona funcao B"
git commit -m "test(algo): adiciona testes para A e B"
```

**P: Esqueci de criar a issue antes. E agora?**
R: Crie agora e coloque `Closes #[numero]` no corpo do PR.

**P: Como faço rebase interativo para "limpar" commits?**
R: Se tem 3 commits: `git rebase -i HEAD~3` (mas isso é avançado).

---

## 🎓 Aprender Mais

Leia [`BRANCHING_STRATEGY.md`](BRANCHING_STRATEGY.md) para a documentação completa.
