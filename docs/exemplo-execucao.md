# Exemplo de Execução

Saída esperada ao rodar o programa com o labirinto padrão.

> **Nota:** confirme a saída real rodando o programa no seu ambiente e, se
> necessário, atualize a contagem de passos abaixo. Use as capturas de tela
> reais no documento de entrega.

## Comando

```bat
build.bat
labirinto.exe
```

## Menu inicial

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

## Saída da opção 5 (estático), resumida

```
Labirinto original:

#################################################
E.....#...........#.................#...........#
#.###.#.#.#######.#.#####.#########.#.#####.###.#
...
#...........................#...................S
#################################################

Entrada encontrada em (linha 1, coluna 0).
Saida   encontrada em (linha 19, coluna 48).

Labirinto resolvido (caminho marcado com '*'):

#################################################
E*****#...........#.................#...........#
#.###*#.#.#######.#.#####.#########.#.#####.###.#
#...#*#.#.......#.#.....#.....#.....#.....#...#.#
###.#*#.#######.#.#####.#####.#.#########.###.#.#
#...#*********#.....#...#.....#.......#.....#...#
#.###.#######*#######.###.###########.#.#####.###
#.....#.....#*******#...#.....#.......#.....#...#
#####.#.###.#######*###.###.#.#.###########.###.#
#.....#...#.......#*****#...#.#.....#.......#...#
#.#######.#######.#####*#.###.#####.#.#######.#.#
#.......#.....#........*#...#.....#.#.......#.#.#
#######.#####.#.#######*###.#####.#.#######.#.#.#
#.....#.....#.#.....#***#.......#.#.....#...#.#.#
#.###.#####.#.###.#.#*#########.#.#####.#.###.#.#
#...#.......#.....#.#*********#.#.......#.....#.#
###.###############.#########*#.###############.#
#.................#.........#*#.................#
#.#########################.#*#################.#
#...........................#*******************S
#################################################

Quantidade de passos do menor caminho: <confirme rodando>
```

## Opções 1 a 4 (animado)

Nas opções animadas, a tela mostra a busca acontecendo passo a passo:

- **Fase 1 (exploração):** as posições visitadas vão aparecendo como `:`
  (a "onda" da busca se espalhando a partir da entrada).
- **Fase 2 (caminho):** o menor caminho é desenhado célula a célula com `*`.
- Com áudio (opções 2 e 4): sons tocam durante a animação (em *thread* paralela).
- Ao final: `>>> Caminho encontrado! Quantidade de passos: N`.

As opções 1/2 usam **BFS**; as opções 3/4 usam **Dijkstra** — o caminho final é
o mesmo (mesmo número de passos), pois o peso de cada movimento é 1.

## Teste: labirinto sem solução

Se você fechar a saída com paredes (cercar o `S` de `#`), a saída esperada é:

```
Nao existe caminho entre a entrada e a saida.
```

## Casos de borda

| Caso                       | Resultado esperado                          |
|----------------------------|---------------------------------------------|
| Labirinto padrão           | Caminho marcado com `*` + nº de passos      |
| Saída cercada por paredes  | "Nao existe caminho entre a entrada e a saida." |
| BFS vs Dijkstra            | Mesmo número de passos                      |

> **Nota:** confirme a contagem de passos real rodando o programa e use as
> capturas de tela reais no documento de entrega.
