# 📋 Issues Prontas para Criar

Copie e cole cada comando no terminal para criar as issues do projeto.

---

## 🏗️ NÚCLEO — Implementação Base

### Issue #1: Estruturas e Tipos de Dados

```bash
gh issue create \
  --title "[Feat] Implementar estruturas Posicao, Labirinto e Resultado" \
  --body "Criar as structs base do projeto:
- Posicao (linha, coluna) representando um vértice
- Labirinto (grade, dimensões)
- Resultado (caminho, passos, ordem de visita)

Incluir constantes MAX_LINHAS, MAX_COLUNAS e MAX_CELULAS.

**Arquivos:** labirinto.h, labirinto.c" \
  --label "feature,core"
```

### Issue #2: Funções Auxiliares do Núcleo

```bash
gh issue create \
  --title "[Feat] Implementar funções auxiliares (carregar, exibir, localizar)" \
  --body "Criar funções auxiliares:
- carregarDoVetor(): copia desenho para matriz
- exibirLabirinto(): imprime matriz na tela
- localizar(): procura 'E' ou 'S'
- ehLivre(): valida limites e paredes

**Arquivos:** labirinto.c, labirinto.h" \
  --label "feature,core"
```

### Issue #3: Algoritmo BFS (Busca em Largura)

```bash
gh issue create \
  --title "[Feat] Implementar BFS para encontrar menor caminho" \
  --body "Implementar resolverLabirinto() usando Busca em Largura:
- Usar fila para explorar em ondas
- Controlar visitados para evitar loops
- Registrar pai de cada posição para reconstrução
- Reconstruir caminho da saída até entrada

Justificativa: com peso 1, BFS garante menor caminho.

**Arquivos:** labirinto.c, labirinto.h" \
  --label "feature,algo"
```

### Issue #4: Algoritmo Dijkstra

```bash
gh issue create \
  --title "[Feat] Implementar Dijkstra para comparação didática" \
  --body "Implementar resolverDijkstra() para demonstrar equivalência com BFS quando peso = 1:
- Manter matriz de distâncias
- Escolher posição não visitada de menor distância
- Relaxar vizinhos
- Reconstruir caminho (idêntico ao BFS)

Objetivo: mostrar que com pesos iguais, Dijkstra = BFS.

**Arquivos:** labirinto.c, labirinto.h" \
  --label "feature,algo"
```

### Issue #5: Visualização e Animação

```bash
gh issue create \
  --title "[Feat] Implementar animação passo a passo do labirinto" \
  --body "Criar animarBusca() em visualizacao.c:
- Fase 1: mostrar exploração (nós visitados como ':')
- Fase 2: desenhar menor caminho (células como '*')
- Usar reposicionamento de cursor (sem limpar tela inteira)
- Suportar dois modos: com e sem animação

Usar irParaTopo() em vez de system('cls').

**Arquivos:** visualizacao.c, visualizacao.h" \
  --label "feature,viz"
```

### Issue #6: Áudio com Threads

```bash
gh issue create \
  --title "[Feat] Implementar áudio assíncrono em thread" \
  --body "Criar bipAssincrono() para tocar sons sem travar animação:
- Disparar Beep() em thread separada com CreateThread()
- Som a cada 3 nós na exploração (frequência variável)
- Ton subindo no caminho (100-1000 Hz)
- Fanfarra ao final

Solução: threads paralelas para não bloquear o desenho.

**Arquivos:** visualizacao.c, visualizacao.h" \
  --label "feature,viz"
```

### Issue #7: Menu Principal

```bash
gh issue create \
  --title "[Feat] Implementar menu com 6 opções" \
  --body "Criar menu principal em main.c com opções:
1. BFS sem áudio
2. BFS com áudio
3. Dijkstra sem áudio
4. Dijkstra com áudio
5. Modo estático
0. Sair

Usar carregarPadrao() para labirinto embutido.

**Arquivos:** main.c" \
  --label "feature,core"
```

---

## 🧪 TESTES — Validação

### Issue #8: Testes Unitários para BFS

```bash
gh issue create \
  --title "[Test] Criar testes unitários para BFS" \
  --body "Adicionar 6 testes em testes.c:
- teste_carregar: validar dimensões da matriz
- teste_localizar: achar E e S
- teste_ehLivre: paredes e limites
- teste_caminho: BFS encontra menor caminho (6 passos)
- teste_sem_caminho: detecta ausência
- teste_marcar: marca com '*' preservando E e S

Usar assert.h (C ANSI puro).

**Arquivos:** testes.c" \
  --label "test,algo"
```

### Issue #9: Testes para Dijkstra

```bash
gh issue create \
  --title "[Test] Criar testes para Dijkstra" \
  --body "Adicionar 2 testes em testes.c:
- teste_dijkstra: verifica se encontra mesmo caminho que BFS (6 passos)
- teste_dijkstra_sem_caminho: detecta ausência de caminho

Validar que Dijkstra = BFS quando peso = 1.

**Arquivos:** testes.c" \
  --label "test,algo"
```

### Issue #10: Testes de Integração

```bash
gh issue create \
  --title "[Test] Validar compilação e execução completa" \
  --body "Validar que:
- \`gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe\` compila sem avisos
- \`build.bat\` compila programa + testes
- \`testes.exe\` passa todos os 8 testes
- \`labirinto.exe\` executa todas as 6 opções do menu

Testar com labirinto padrão e outro labirinto.

**Arquivos:** build.bat, run-tests.bat" \
  --label "test,core"
```

---

## 📚 DOCUMENTAÇÃO

### Issue #11: Documento de Entrega

```bash
gh issue create \
  --title "[Docs] Preencher documento de entrega (seção 11)" \
  --body "Completar docs/documento-entrega.md:
1. Nomes dos integrantes e matrículas
2. Confirmação de compilação sem avisos
3. Confirmação de testes passados

Este documento é obrigatório pela seção 11 do enunciado.

**Arquivos:** docs/documento-entrega.md" \
  --label "documentation,urgent"
```

### Issue #12: Capturas de Tela do Programa Funcionando

```bash
gh issue create \
  --title "[Docs] Adicionar capturas de tela da execução" \
  --body "Capturar e anexar prints de:
1. Labirinto original (opção 5 - estático)
2. Labirinto resolvido com caminho marcado

Anexar em docs/documento-entrega.md.

**Arquivo:** docs/documento-entrega.md" \
  --label "documentation,urgent"
```

### Issue #13: Guia de Apresentação Completo

```bash
gh issue create \
  --title "[Docs] Validar guia de apresentação para teste de autoria" \
  --body "Revisar e validar docs/guia-apresentacao.md:
1. Verificar se cobre todas as 11 questões do professor
2. Confirmar que os exemplos de 'alteração ao vivo' funcionam
3. Validar perguntas e respostas preparadas

Este documento é crítico para o teste de autoria (25/06/2026).

**Arquivo:** docs/guia-apresentacao.md" \
  --label "documentation,urgent"
```

---

## 🔧 REFATORAÇÃO E CORREÇÃO

### Issue #14: Teste de Áudio (teste-som.c)

```bash
gh issue create \
  --title "[Test] Implementar teste isolado de áudio" \
  --body "Criar teste-som.c com 3 testes de Beep():
1. Bell do terminal (\\a)
2. Um bip longo de 1 segundo
3. Uma escala musical (8 notas)

Serve para diagnóstico se o áudio está funcionando.

**Arquivo:** teste-som.c" \
  --label "test,viz"
```

---

## 📊 Resumo de Issues

| Núcleo | Testes | Docs | Total |
|--------|--------|------|-------|
| 7 issues | 4 issues | 3 issues | **14 issues** |

---

## 🚀 Como Executar

### Opção 1: Criar uma por uma (recomendado para começar)

```bash
# Copie e cole um comando por vez
gh issue create --title "..." --body "..."

# Anote o número da issue (#1, #2, etc.)
# Use para criar a branch e o PR depois
```

### Opção 2: Script em Bash (avançado)

Salve num arquivo `create_issues.sh` e rode:

```bash
#!/bin/bash
gh issue create --title "[Feat] Estruturas..." --body "..." --label "feature,core"
gh issue create --title "[Feat] Funções..." --body "..." --label "feature,core"
# ... etc
```

Depois:

```bash
chmod +x create_issues.sh
./create_issues.sh
```

---

## 📝 Template para Sua Issue Customizada

Se quiser criar uma fora da lista:

```bash
gh issue create \
  --title "[Tipo] Descrição breve" \
  --body "Descrição detalhada

**Arquivos afetados:** arquivo1.c, arquivo2.h

**Critérios de aceitação:**
- [ ] Item 1
- [ ] Item 2
" \
  --label "label1,label2"
```

Labels disponíveis:
- `feature`, `bug`, `documentation`, `test`
- `core`, `algo`, `viz`, `build`
- `urgent`, `ready`, `in-progress`, `review`
