# Glossário

Termos de grafos e do código, em linguagem simples.

## Conceitos de grafos

- **Grafo:** conjunto de pontos (vértices) ligados por conexões (arestas).
- **Vértice (nó):** um ponto do grafo. Aqui, cada posição livre do labirinto.
- **Aresta:** uma ligação entre dois vértices. Aqui, a passagem entre duas
  células livres vizinhas.
- **Peso:** "custo" de uma aresta. Aqui é sempre 1 (cada passo conta igual).
- **Vizinho:** vértice diretamente ligado a outro por uma aresta.
- **Caminho:** sequência de vértices ligados por arestas.
- **Menor caminho:** o caminho com o menor número de passos (ou menor custo).
- **Grafo implícito:** quando não guardamos a lista de conexões; calculamos os
  vizinhos na hora. É o caso deste labirinto.

## Algoritmos

- **BFS (Busca em Largura):** explora o grafo em "ondas", visitando primeiro os
  vértices mais próximos. Com pesos iguais, encontra o menor caminho.
- **DFS (Busca em Profundidade):** vai fundo em um caminho antes de voltar. Acha
  *um* caminho, mas não garante o menor. (Não usado neste projeto.)
- **Dijkstra:** acha o menor caminho usando distâncias; funciona até com pesos
  diferentes. Aqui dá o mesmo resultado da BFS (peso 1).
- **Relaxar (relaxamento):** no Dijkstra, atualizar a distância de um vizinho
  quando se descobre um caminho mais curto até ele.
- **Distância:** no Dijkstra, o menor custo conhecido para chegar a uma posição
  (começa em "infinito" para todas, menos a entrada, que é 0).
- **Fila (FIFO):** estrutura "primeiro a entrar, primeiro a sair". É o que faz a
  BFS funcionar.

## Termos do código

- **`Posicao`:** `struct` com `linha` e `coluna`; representa um vértice.
- **`Labirinto`:** `struct` com a `grade` (matriz) e suas dimensões.
- **`Resultado`:** `struct` com a saída da busca (caminho, passos, ordem de visita).
- **`grade`:** matriz de caracteres com o desenho do labirinto.
- **`visitado`:** matriz que marca posições já exploradas (evita loop).
- **`pai`:** matriz que guarda, para cada posição, de onde chegamos a ela; usada
  na reconstrução do caminho.
- **`fila`:** vetor usado como fila da BFS.
- **`dist`:** matriz de distâncias usada pelo Dijkstra.
- **`ordemVisita`:** lista da ordem em que as posições foram visitadas (usada na
  animação).
- **`deslocaLinha` / `deslocaColuna`:** vetores que definem os 4 movimentos.
- **`ehLivre`:** função que diz se uma posição pode ser visitada (dentro dos
  limites e não é parede).
- **`resolverLabirinto` / `resolverDijkstra`:** as duas funções de busca.
- **Reconstrução do caminho:** processo de refazer o caminho da saída até a
  entrada usando a matriz `pai`.

## Termos da visualização (extra, Windows)

- **`Beep`:** função do Windows que toca um som de dada frequência e duração.
- **Thread:** linha de execução paralela. Usada para tocar o som **sem** travar
  a animação (o `Beep` é bloqueante).
- **`bipAssincrono`:** dispara o som numa thread separada.
- **Buffer de tela / cursor:** em vez de limpar a tela toda hora, o programa
  reposiciona o cursor no topo e redesenha por cima (evita o "piscar").
