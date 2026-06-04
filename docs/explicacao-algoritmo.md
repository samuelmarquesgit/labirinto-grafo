# Explicação do Algoritmo (para o Teste de Autoria)

Este documento explica, em detalhe, como o programa funciona. Serve de **roteiro
de estudo** para o teste de autoria, onde cada integrante pode ser questionado.

---

## 1. O labirinto como grafo

Imagine cada célula livre do labirinto como um **ponto (vértice)**. Se duas
células livres estão coladas (uma do lado da outra, em cima/baixo/esquerda/
direita), existe um **caminho (aresta)** entre elas.

```
. .      vira       (o)---(o)
. .                  |     |
                    (o)---(o)
```

- **Vértice** = posição livre (`.`, `E`, `S`).
- **Aresta** = ligação entre duas posições livres vizinhas.
- **Parede `#`** = não é vértice (não dá para passar).
- **Peso** = todo movimento custa 1.

> O grafo é **implícito**: não montamos uma lista de adjacência. Os vizinhos são
> descobertos na hora, somando os vetores de deslocamento à posição atual.

## 2. Os algoritmos: BFS, Dijkstra (e por que não DFS)

Este projeto implementa **dois** algoritmos (`resolverLabirinto` = BFS;
`resolverDijkstra` = Dijkstra). Ambos acham o menor caminho aqui.

| Algoritmo | Acha o menor caminho? | Observação                              |
|-----------|----------------------|------------------------------------------|
| **BFS**   | **Sim** (pesos iguais)| Principal. Simples e correto aqui.       |
| **Dijkstra** | **Sim**           | Implementado p/ comparar. Mesmo resultado com peso 1. |
| DFS       | Não necessariamente   | Acha *um* caminho, não o menor. (Não usado.) |

A **BFS explora em "ondas"**: primeiro todas as posições a 1 passo da entrada,
depois a 2 passos, depois a 3... Logo, a primeira vez que ela toca a saída é
necessariamente pelo **menor número de passos**.

## 3. As estruturas usadas

```c
typedef struct { int linha; int coluna; } Posicao;

int     visitado[L][C];  /* já passei aqui? (evita loop)            */
Posicao pai[L][C];       /* de qual posição cheguei aqui?           */
Posicao fila[L*C];       /* fila da BFS (ordem de visita)           */
```

- **`visitado`** — sem ele, o algoritmo voltaria a posições já vistas e entraria
  em loop infinito.
- **`pai`** — é o segredo da **reconstrução**. Guardando "de onde vim", consigo
  refazer o caminho de trás para frente.
- **`fila`** — garante a ordem "primeiro a entrar, primeiro a sair" (FIFO), que é
  o que faz a BFS explorar em ondas.

## 4. Os 4 movimentos

```c
int deslocaLinha[4]  = { -1,  1,  0,  0 };
int deslocaColuna[4] = {  0,  0, -1,  1 };
```

| d | deslocaLinha | deslocaColuna | Direção  |
|---|--------------|---------------|----------|
| 0 | -1           | 0             | cima     |
| 1 | +1           | 0             | baixo    |
| 2 | 0            | -1            | esquerda |
| 3 | 0            | +1            | direita  |

Para cada posição `atual`, o vizinho `d` é
`(atual.linha + deslocaLinha[d], atual.coluna + deslocaColuna[d])`.

## 5. A BFS, passo a passo

```
1. Marca a ENTRADA como visitada e coloca na fila.
2. Enquanto a fila NÃO estiver vazia:
     a. Retira a posição da frente (atual).
     b. Se atual == SAÍDA  -> encontrou! para.
     c. Para cada vizinho (4 direções):
          - se for livre E não visitado:
              * marca como visitado
              * pai[vizinho] = atual
              * coloca o vizinho na fila
3. Se a fila esvaziou sem achar a saída -> NÃO existe caminho.
```

## 6. Reconstrução do caminho

Depois de achar a saída, partimos dela e seguimos os "pais" até a entrada:

```
posição = SAÍDA
enquanto posição != ENTRADA:
    marca posição com '*'   (sem apagar 'S')
    posição = pai[posição]
    passos = passos + 1
```

No fim, o caractere `*` desenha o menor caminho dentro do labirinto, e `passos`
contém quantos movimentos foram feitos. (A reconstrução é **idêntica** na BFS e
no Dijkstra, pois ambos preenchem a mesma matriz `pai`.)

## 7. O Dijkstra (segundo algoritmo)

O Dijkstra resolve o mesmo problema por **distâncias**, em vez de fila:

```
1. dist[ENTRADA] = 0; dist de todas as outras = INFINITO.
2. Repete:
     a. escolhe a posição livre NÃO visitada de MENOR dist.
     b. se não há nenhuma -> para. Se for a SAÍDA -> encontrou.
     c. marca como visitada.
     d. para cada vizinho livre: se dist[atual] + 1 < dist[vizinho],
        atualiza dist[vizinho] e pai[vizinho]  (isso é "relaxar").
3. Reconstrução igual à da BFS (segue os 'pais').
```

- **Relaxar** = "achei um jeito mais curto de chegar nesse vizinho, então
  atualizo a distância dele".
- Como **todo peso é 1**, o Dijkstra acaba visitando na mesma ordem de distância
  que a BFS e encontra **o mesmo** menor caminho.
- Nesta versão, a escolha da menor distância é feita por **varredura linear**
  (sem fila de prioridade) — simples e suficiente para o tamanho do labirinto.

> **Resumo para defender:** "Com pesos iguais a 1, BFS e Dijkstra dão o mesmo
> resultado. Usei a BFS como principal por ser mais simples; o Dijkstra está aí
> para mostrar que eu entendo o caso geral, em que os pesos poderiam ser
> diferentes."

## 8. Perguntas prováveis no teste de autoria

- **O que é um vértice e uma aresta neste programa?**
  Vértice = célula livre; aresta = ligação entre células vizinhas livres.
- **Como o programa evita andar em círculos?**
  Pela matriz `visitado`.
- **Como o caminho é remontado?**
  Pela matriz `pai`, indo da saída até a entrada.
- **Por que a BFS dá o menor caminho?**
  Porque explora por ondas de distância e os pesos são todos 1.
- **Qual a diferença entre BFS e Dijkstra aqui?**
  O método: BFS usa fila; Dijkstra usa distâncias. O resultado é o mesmo porque
  o peso é 1.
- **Por que não usou recursão?**
  Porque a BFS é iterativa (fila + laço). Recursão seria natural na DFS, que
  **não** garante o menor caminho.
- **O que acontece se não houver caminho?**
  A busca termina sem alcançar `S`; `existeCaminho` fica 0 e o programa avisa.
- **Como testar outro labirinto?**
  Editar o vetor `desenho` em `carregarPadrao()` (no `main.c`).
