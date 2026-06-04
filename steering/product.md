# Steering — Produto

Diretrizes sobre **o que** este projeto é e para quem.

## Propósito

Aplicar, de forma prática, conceitos de Estrutura de Dados — **matrizes,
funções, structs, grafos e algoritmos de busca** — resolvendo um problema real:
encontrar o menor caminho em um labirinto.

## Público

- **Avaliador (professor):** conduz o *teste de autoria*, podendo pedir
  alterações ao vivo no labirinto e no código.
- **Integrantes da equipe:** devem entender e saber explicar **todas** as partes
  do código (matriz, funções, struct, grafos, vértices, arestas, visitados,
  busca, reconstrução).

## Princípios do produto

1. **Clareza acima de esperteza.** O código deve ser fácil de explicar, não o
   mais "otimizado" possível. Comentários didáticos são parte do entregável.
2. **Funcionar é obrigatório.** Código que não compila ou não executa não é
   aceito. Verificar antes de apresentar.
3. **Genérico, não fixo.** O programa deve resolver **qualquer** labirinto
   válido, não imprimir um resultado fixo.
4. **Modo console.** Apenas caracteres; nada de interface gráfica.
5. **Núcleo ANSI inegociável.** A lógica (matriz, grafo, busca) é C ANSI puro.
   Recursos que dependem do sistema (som/animação) ficam **isolados** e são
   tratados como **extras opcionais**.

## Funcionalidades entregues

- Resolução por **BFS** e por **Dijkstra** (comparação didática).
- Modo **estático** e modo **animado** (exploração passo a passo).
- **Áudio opcional** durante a animação (extra didático).
- Detecção de **ausência de caminho**.
- **Testes automatizados** do núcleo.

## Escopo: o que entra como NÚCLEO vs EXTRA

| Item | Classificação | Observação |
|------|---------------|-----------|
| Matriz, grafo, BFS, Dijkstra, reconstrução | **Núcleo (ANSI)** | É o que o enunciado exige |
| Modo estático (opção 5) | **Núcleo (ANSI)** | Suficiente para a entrega |
| Animação na tela | **Extra** | Usa API de console do Windows |
| Áudio (`Beep` em *thread*) | **Extra** | Usa `windows.h`; não é ANSI |

## Fora de escopo

- Interface gráfica (janelas/botões).
- Movimentos diagonais.
- Pesos diferentes entre movimentos (todos custam 1).
- Leitura do labirinto de arquivo externo (hoje é embutido no código).

> ⚠️ **Nota sobre C ANSI:** o áudio e a animação usam `windows.h`, que **não é**
> C ANSI. São extras. O requisito de C ANSI é cumprido pelo núcleo
> (`labirinto.c`) e pela opção **5 (estático)** do menu.

## Critério de sucesso

O programa exibe corretamente o labirinto original e o resolvido, encontra o
menor caminho (ou informa que não existe), e a equipe consegue **defender** cada
decisão no teste de autoria.
