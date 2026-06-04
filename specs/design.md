# Design — Labirinto com Grafos

Decisões de projeto e arquitetura da solução.

## 1. Modelagem como grafo

| Conceito do grafo | Elemento no labirinto                                   |
|-------------------|---------------------------------------------------------|
| Vértice           | Cada posição livre (`.`, `E`, `S`)                      |
| Aresta            | Ligação entre duas posições livres vizinhas (4 direções)|
| Peso da aresta    | Sempre 1 (cada movimento = 1 passo)                     |
| Não é vértice     | Paredes `#`                                              |

O grafo é **implícito**: não existe uma lista/matriz de adjacência explícita.
Os vizinhos de uma posição são calculados em tempo de execução somando os
vetores de deslocamento. Isso economiza memória e é o padrão para labirintos
em grade.

## 2. Algoritmos de busca

O projeto implementa **dois** algoritmos, ambos garantindo o menor caminho
neste cenário (peso 1):

### 2.1 BFS (Busca em Largura) — principal

- Usa uma **fila**: visita os vértices em ordem crescente de distância da origem.
- Com pesos iguais, a primeira vez que alcança a saída já é pelo **menor caminho**.
- Simples e eficiente; é a escolha recomendada pelo enunciado.

### 2.2 Dijkstra — comparação didática

- Mantém uma **distância** para cada posição (começando em "infinito").
- A cada passo, escolhe a posição não visitada de **menor distância** e
  **relaxa** os vizinhos (`dist[atual] + 1`).
- Com todos os pesos iguais a 1, produz **exatamente o mesmo** menor caminho da
  BFS — a diferença é o método.

> **Por que ter os dois?** Para demonstrar a equivalência quando os pesos são
> iguais e poder justificar a escolha no teste de autoria: "BFS basta aqui;
> Dijkstra só seria necessário se os pesos fossem diferentes".

## 3. Estruturas de dados

```c
typedef struct {            /* um VÉRTICE */
    int linha;
    int coluna;
} Posicao;

typedef struct {            /* a GRADE + dimensões */
    char grade[MAX_LINHAS][MAX_COLUNAS];
    int  numLinhas;
    int  numColunas;
} Labirinto;

typedef struct {            /* SAÍDA da busca */
    int     existeCaminho;
    int     passos;
    Posicao caminho[MAX_CELULAS];      /* entrada -> saída */
    int     tamanhoCaminho;
    Posicao ordemVisita[MAX_CELULAS];  /* ordem visitada (p/ animação) */
    int     totalVisitados;
} Resultado;
```

Estruturas auxiliares **internas** às funções de busca (`static`):

- **`visitado[][]`**: evita revisitar posições e entrar em loop.
- **`pai[][]`**: para cada posição, de onde chegamos — base da reconstrução.
- **`fila[]`** (BFS): vetor com índices `inicio`/`fim` (FIFO).
- **`dist[][]`** (Dijkstra): distância mínima conhecida até cada posição.

## 4. Vetores de deslocamento

```c
static const int deslocaLinha[4]  = { -1,  1,  0,  0 };  /* cima, baixo, -, -    */
static const int deslocaColuna[4] = {  0,  0, -1,  1 };  /* -, -, esq, direita   */
```

Somando `(deslocaLinha[d], deslocaColuna[d])` à posição atual obtemos cada um
dos 4 vizinhos.

## 5. Fluxo do programa

```
main()
 ├── carregarPadrao() → carregarDoVetor()   # monta a matriz
 ├── menu (laço while)
 │     ├── opção 1/2 → resolverLabirinto() (BFS) → animarBusca()
 │     ├── opção 3/4 → resolverDijkstra()       → animarBusca()
 │     └── opção 5   → mostrarEstatico() → resolverLabirinto() + marcarCaminho()
 └── sair
```

## 6. BFS (passo a passo)

1. Marca a entrada como visitada e a coloca na fila.
2. Enquanto a fila não estiver vazia:
   1. Remove a posição da frente (`atual`).
   2. Se `atual` é a saída → para (caminho encontrado).
   3. Para cada um dos 4 vizinhos: se livre e não visitado → marca, registra
      `pai` e enfileira.
3. Se alcançou a saída, reconstrói o caminho seguindo `pai` da saída até a
   entrada, e conta os passos.
4. Se a fila esvaziar sem alcançar a saída → **não existe caminho**.

## 7. Dijkstra (passo a passo)

1. Distância da entrada = 0; todas as outras = infinito.
2. Repete:
   1. Escolhe a posição livre **não visitada** de **menor distância**.
   2. Se não há nenhuma → para. Se é a saída → encontrou.
   3. Marca como visitada e **relaxa** os 4 vizinhos: se `dist + 1` for menor,
      atualiza a distância e o `pai`.
3. Reconstrução idêntica à da BFS.

## 8. Visualização (módulo `visualizacao.c`)

- A busca é resolvida **primeiro** (em silêncio); a animação apenas **reproduz**
  o que foi guardado em `ordemVisita` e `caminho`.
- **Desenho:** em vez de `system("cls")` a cada quadro, reposiciona o cursor no
  topo (`SetConsoleCursorPosition`) e redesenha por cima — evita piscar.
- **Áudio:** `bipAssincrono` dispara o `Beep` numa **thread** (`CreateThread`),
  para o som tocar em paralelo sem travar o desenho.

## 9. Complexidade

| Algoritmo | Complexidade | Observação |
|-----------|--------------|-----------|
| BFS       | **O(V + E)** | Em grade, ~O(linhas × colunas) |
| Dijkstra (seleção linear) | **O(V²)** | Sem fila de prioridade; ok p/ este tamanho |

`V` = nº de células livres; `E` = nº de arestas (≤ 4·V).

## 10. Limitações e decisões

- Tamanho máximo definido por `MAX_LINHAS` e `MAX_COLUNAS` (ajustáveis).
- Labirinto embutido no código (vetor de strings); trocar = editar o vetor.
- Matrizes auxiliares `static` para não estourar a pilha.
- Áudio/animação dependem do Windows; o núcleo lógico é portável/ANSI.
