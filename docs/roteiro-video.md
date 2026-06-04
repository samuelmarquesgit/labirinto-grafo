# Roteiro de Vídeo — Como o Programa Funciona (passo a passo)

Este documento é um **roteiro narrado**: ele segue a execução do programa do
início ao fim, dizendo **quais funções são chamadas e em que ordem**. Use como
texto-base para gravar um vídeo explicativo ou para se preparar para o teste de
autoria.

> ⚠️ **Sobre recursão:** este programa **não usa recursão**. O algoritmo de
> busca (BFS) é **iterativo** — ele usa uma **fila** e um laço `while`. Mais
> adiante explico por quê. (Se você precisasse de recursão, usaria DFS; veja a
> seção "Recursão" no fim.)

---

## CENA 0 — Visão geral (abertura do vídeo)

> "Este programa resolve um labirinto usando **grafos**. Cada espaço livre é um
> **vértice**, cada passagem entre dois espaços vizinhos é uma **aresta**, e o
> objetivo é achar o **menor caminho** da entrada `E` até a saída `S`. Para isso
> usamos a **Busca em Largura (BFS)**."

O projeto está dividido em módulos:

| Arquivo          | Papel                                            |
|------------------|--------------------------------------------------|
| `labirinto.c`    | A lógica (carregar, exibir, localizar, BFS)      |
| `visualizacao.c` | A animação na tela + o som a cada nó             |
| `main.c`         | O menu que controla tudo                         |

---

## CENA 1 — O programa começa: `main()`

Arquivo: **`main.c`**

Quando você roda `labirinto.exe`, a primeira função a executar é `main()`.
A ordem de chamadas é:

```
main()
 └── carregarPadrao()
       └── carregarDoVetor()
```

> "Assim que o programa abre, o `main` chama `carregarPadrao`, que por sua vez
> chama `carregarDoVetor`."

### O que `carregarDoVetor` faz

Ela recebe o desenho do labirinto (um **vetor de strings**) e copia, caractere
por caractere, para dentro da matriz `grade` da `struct Labirinto`. Também
descobre quantas linhas e colunas o labirinto tem.

> "Aqui o labirinto deixa de ser um texto e vira uma **matriz de caracteres** na
> memória, pronta para ser processada."

---

## CENA 2 — O menu

Arquivo: **`main.c`** (laço `while` dentro de `main`)

O programa mostra:

```
========= LABIRINTO COM GRAFOS (BFS) =========
1 - Busca em Largura (BFS)  (Sem Audio)
2 - Busca em Largura (BFS)  (Com Audio)
3 - Algoritmo de Dijkstra (Sem Audio)
4 - Algoritmo de Dijkstra (Com Audio)
5 - Mostrar resolucao (estatico)
0 - Sair
Escolha uma opcao:
```

O `scanf("%d", &opcao)` lê o número digitado. O despacho é:

| Opção | Algoritmo | Modo |
|-------|-----------|------|
| 1 / 2 | `resolverLabirinto` (BFS) | animado (sem / com áudio) |
| 3 / 4 | `resolverDijkstra` | animado (sem / com áudio) |
| 5     | `resolverLabirinto` (BFS) | estático |

> "Eu escolho o algoritmo e o modo. As opções 1 e 2 usam **BFS**; 3 e 4 usam
> **Dijkstra**; e a 5 mostra o resultado de uma vez, sem animação."

---

## CENA 3 — Caminho A: opção 5 (resolução estática)

Arquivo: **`main.c` → `mostrarEstatico()`**

Ordem das chamadas:

```
mostrarEstatico()
 ├── resolverLabirinto()      <- o coração do programa (a BFS)
 ├── exibirLabirinto()        <- mostra o labirinto original
 ├── marcarCaminho()          <- escreve '*' no caminho
 └── exibirLabirinto()        <- mostra o labirinto resolvido
```

> "Na opção 5, primeiro resolvemos o labirinto, depois mostramos o original e o
> resolvido, com o caminho marcado por asteriscos e a quantidade de passos."

A função central aqui é a `resolverLabirinto` — detalhada na **CENA 5**.

---

## CENA 4 — Caminho B: opções 1 a 4 (animação)

Arquivo: **`main.c`** chama **`visualizacao.c → animarBusca()`**

Ordem das chamadas:

```
resolverLabirinto()  ou  resolverDijkstra()   <- resolve PRIMEIRO (em silêncio)
animarBusca()                                  <- depois ANIMA o que foi resolvido
```

> "Repare numa coisa importante: o programa **primeiro resolve** o labirinto
> inteiro e só **depois anima**. A animação não está 'pensando' — ela está
> **reproduzindo** o que a busca já descobriu, guardado nos vetores `ordemVisita`
> e `caminho`. Por isso BFS e Dijkstra animam do mesmo jeito."

A `animarBusca` é detalhada na **CENA 6**.

---

## CENA 5 — O coração: `resolverLabirinto()` (a BFS)

Arquivo: **`labirinto.c`**

Esta é a função mais importante. Ordem interna das chamadas:

```
resolverLabirinto()
 ├── localizar('E')        <- acha a entrada
 ├── localizar('S')        <- acha a saída
 ├── (laço da BFS)
 │     └── ehLivre()       <- chamada VÁRIAS vezes (para cada vizinho)
 └── (reconstrução do caminho)
```

### Passo 5.1 — Localizar entrada e saída

`localizar('E')` e `localizar('S')` varrem a matriz até achar os caracteres.
Se faltar a entrada ou a saída, a função para aqui (não há o que resolver).

### Passo 5.2 — Preparar a BFS

Três estruturas são preparadas:

- **`visitado`**: marca quais posições já foram vistas (evita andar em círculos).
- **`pai`**: guarda, para cada posição, **de onde chegamos nela** (isso é o que
  permite reconstruir o caminho depois).
- **`fila`**: a fila da BFS. A entrada é a primeira a entrar.

### Passo 5.3 — O laço principal (a "onda" da BFS)

> "A BFS funciona como uma **onda na água**: ela se espalha pela entrada,
> alcança primeiro todos os vizinhos a 1 passo, depois os a 2 passos, e assim
> por diante. Por isso, quando a onda toca a saída, é garantidamente pelo
> **menor número de passos**."

O laço é assim, em palavras:

```
Enquanto a fila não estiver vazia:
    1. Retira a posição da frente da fila (atual).
    2. Se 'atual' for a saída -> achamos! para.
    3. Para cada um dos 4 vizinhos (cima, baixo, esquerda, direita):
         - se ehLivre(vizinho) e ainda não foi visitado:
             * marca como visitado
             * registra pai[vizinho] = atual
             * coloca o vizinho na fila
```

A função `ehLivre()` é chamada aqui **muitas vezes** — uma para cada vizinho de
cada posição. Ela responde: "dá para pisar aqui?" (está dentro da matriz e não é
parede `#`?).

### Passo 5.4 — Reconstruir o caminho

Quando a saída é alcançada, partimos **da saída** e voltamos seguindo a matriz
`pai`, até chegar na entrada:

```
posição = SAÍDA
enquanto posição != ENTRADA:
    guarda a posição
    posição = pai[posição]   <- volta um passo
```

No fim invertemos a lista (para começar na entrada) e contamos os passos.

> "É como deixar um rastro de migalhas: a matriz `pai` diz de onde viemos, então
> conseguimos refazer o caminho de trás para frente."

---

## CENA 6 — A animação: `animarBusca()`

Arquivo: **`visualizacao.c`**

A animação tem **duas fases** e usa funções auxiliares de console e áudio:

```
animarBusca()
 ├── irParaTopo()      <- move o cursor pro topo (em vez de limpar a tela toda)
 ├── cabecalho()       <- imprime título e legenda
 ├── exibirLabirinto() <- desenha o quadro atual
 ├── bipAssincrono()   <- toca o som numa THREAD paralela (não trava o desenho)
 └── esperar()         <- pausa alguns milissegundos (Sleep)
```

> 💡 **Detalhe técnico para destacar:** em vez de `system("cls")` a cada quadro
> (que abre um `cmd.exe` toda vez, fazendo a tela piscar e o som cortar), o
> programa só **reposiciona o cursor** no topo e redesenha por cima. E o som é
> tocado por uma **thread** separada, então toca em paralelo sem travar a
> animação.

### Fase 1 — Mostrar a EXPLORAÇÃO

Para cada posição na ordem em que a busca visitou (`res->ordemVisita`):
- marca a célula com `:`;
- reposiciona o cursor e redesenha;
- a cada poucos nós, dispara um bip (em thread);
- espera alguns milissegundos.

> "Aqui você vê a 'onda' da busca se espalhando pelo labirinto, com sons ao
> fundo — é a parte didática."

### Fase 2 — Desenhar o MENOR CAMINHO

Para cada posição do caminho final (`res->caminho`):
- marca a célula com `*`;
- redesenha e toca um tom que vai **subindo** suavemente a cada passo;
- ao terminar, toca uma pequena fanfarra.

> "Quando a exploração acaba, o programa desenha o caminho mais curto, célula a
> célula, terminando com um som de sucesso."

---

## CENA 7 — Quando NÃO existe caminho

Se a saída estiver bloqueada por paredes, a fila da BFS esvazia sem nunca
alcançar o `S`. Nesse caso:

- `resolverLabirinto` deixa `existeCaminho = 0`;
- o programa exibe **"Nao existe caminho entre a entrada e a saida."**
- (na animação, toca um som grave de "erro").

> "Isso prova que o programa não 'inventa' resposta: se realmente não há saída,
> ele avisa claramente."

---

## CENA 8 — Fluxo completo (resumo visual)

```
labirinto.exe
   │
   ▼
main()
   ├── carregarPadrao() ── carregarDoVetor()      [monta a matriz]
   │
   ▼
[menu: você escolhe 1 a 5]
   │
   ├── opção 5 ─► mostrarEstatico()
   │                ├── resolverLabirinto()  ─► localizar, ehLivre (xN), reconstrução
   │                ├── exibirLabirinto()    [original]
   │                ├── marcarCaminho()
   │                └── exibirLabirinto()    [resolvido]
   │
   ├── opção 1/2 ─► resolverLabirinto()  (BFS)
   │                 └── animarBusca()
   │                       ├── irParaTopo / cabecalho / exibirLabirinto
   │                       ├── bipAssincrono()  [som em thread]
   │                       └── esperar()        [pausa]
   │
   └── opção 3/4 ─► resolverDijkstra()   (Dijkstra)
                     └── animarBusca()   [mesma animação]
```

---

## Seção EXTRA — "E a recursão?" (pergunta provável do professor)

> "Professor, este programa **não usa recursão de propósito**. A BFS é
> **iterativa**: ela usa uma **fila** (estrutura FIFO) e um laço `while`. A fila
> é justamente o que garante que exploramos as posições em ordem de distância,
> e é isso que faz a BFS encontrar o **menor** caminho.
>
> Se eu quisesse usar **recursão**, o natural seria a **DFS (Busca em
> Profundidade)** — que mergulha em um caminho até o fim antes de voltar. Mas a
> DFS **não garante o menor caminho**, então não serve para o nosso objetivo.
>
> Resumindo: **fila + laço = BFS = menor caminho**; **pilha/recursão = DFS = um
> caminho qualquer**."

### Onde está cada conceito (cola rápida)

| Conceito             | Onde no código                                  |
|----------------------|-------------------------------------------------|
| Matriz               | `labirinto.grade` (`labirinto.h`)               |
| Struct               | `typedef struct { ... } Posicao;`               |
| Vértice              | uma `Posicao` livre                             |
| Aresta               | o passo para um vizinho (`deslocaLinha/Coluna`) |
| Controle de visitados| matriz `visitado` em `resolverLabirinto`        |
| Reconstrução         | matriz `pai` + laço final                       |
| Algoritmo de busca   | `resolverLabirinto` (BFS) e `resolverDijkstra`  |
| Fila                 | vetor `fila` com índices `inicio`/`fim` (BFS)   |
| Distâncias           | matriz `dist` em `resolverDijkstra`             |
| Áudio em paralelo    | `bipAssincrono` (thread) em `visualizacao.c`    |

---

## Sugestão de duração do vídeo

| Trecho                         | Tempo sugerido |
|--------------------------------|----------------|
| Abertura (CENA 0)              | 30 s           |
| Início e carga (CENAS 1–2)     | 1 min          |
| A BFS (CENA 5) — o principal   | 2–3 min        |
| Animação (CENA 6)              | 1 min (mostre rodando!) |
| Recursão + encerramento        | 1 min          |

> 💡 **Dica de gravação:** ao chegar na CENA 6, rode `labirinto.exe`, escolha a
> opção **2** e grave a tela com o som ligado. A animação fala por si.
