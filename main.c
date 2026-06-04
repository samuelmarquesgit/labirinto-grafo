/* ==========================================================================
 * main.c - Programa principal (menu) 
 *
 * Junta o nucleo ANSI (labirinto.c) com a animacao/audio (visualizacao.c).
 * Oferece um menu para:
 *   1 - mostrar a resolucao de forma estatica;
 *   2 - mostrar a resolucao ANIMADA com audio (a cada no);
 *   3 - mostrar a resolucao animada SEM audio;
 *   0 - sair.
 * ========================================================================== */
#include <stdio.h>
#include <stdlib.h>
#include "labirinto.h"
#include "visualizacao.h"

/* Estruturas grandes ficam aqui (fora da pilha) para nao estourar memoria. */
static Labirinto original;
static Resultado resultado;

/* Carrega o labirinto padrao. Para testar OUTRO labirinto, edite este vetor. */
static void carregarPadrao(void) {
    const char *desenho[] = {
        "#################################################",
        "E.....#...........#.................#...........#",
        "#.###.#.#.#######.#.#####.#########.#.#####.###.#",
        "#...#.#.#.......#.#.....#.....#.....#.....#...#.#",
        "###.#.#.#######.#.#####.#####.#.#########.###.#.#",
        "#...#.#.......#.....#...#.....#.......#.....#...#",
        "#.###.#######.#######.###.###########.#.#####.###",
        "#.....#.....#.......#...#.....#.......#.....#...#",
        "#####.#.###.#######.###.###.#.#.###########.###.#",
        "#.....#...#.......#.....#...#.#.....#.......#...#",
        "#.#######.#######.#######.###.#####.#.#######.#.#",
        "#.......#.....#.........#...#.....#.#.......#.#.#",
        "#######.#####.#.#######.###.#####.#.#######.#.#.#",
        "#.....#.....#.#.....#...#.......#.#.....#...#.#.#",
        "#.###.#####.#.###.#.#.#########.#.#####.#.###.#.#",
        "#...#.......#.....#.#.........#.#.......#.....#.#",
        "###.###############.#########.#.###############.#",
        "#.................#.........#.#.................#",
        "#.#########################.#.#################.#",
        "#...........................#...................S",
        "#################################################"
    };
    int total = (int)(sizeof(desenho) / sizeof(desenho[0]));
    carregarDoVetor(&original, desenho, total);
}

/* Mostra a resolucao de forma estatica (sem animacao), usando a BFS. */
static void mostrarEstatico(void) {
    Labirinto trabalho;

    trabalho = original;
    resolverLabirinto(&trabalho, &resultado);

    printf("\nLabirinto original:\n\n");
    exibirLabirinto(&original);

    if (resultado.existeCaminho) {
        marcarCaminho(&trabalho, &resultado);
        printf("\nLabirinto resolvido (caminho marcado com '*'):\n\n");
        exibirLabirinto(&trabalho);
        printf("\nQuantidade de passos do menor caminho: %d\n",
               resultado.passos);
    } else {
        printf("\nNao existe caminho entre a entrada e a saida.\n");
    }
}

int main(void) {
    int opcao = -1;

    carregarPadrao();

    while (opcao != 0) {
        printf("\n========= LABIRINTO COM GRAFOS (BFS) =========\n");
        printf("1 - Busca em Largura (BFS)  (Sem Audio)\n");
        printf("2 - Busca em Largura (BFS)  (Com Audio)\n");
        printf("3 - Algoritmo de Dijkstra (Sem Audio)\n");
        printf("4 - Algoritmo de Dijkstra (Com Audio)\n");
        printf("5 - Mostrar resolucao (estatico)\n");
        printf("0 - Sair\n");
        printf("Escolha uma opcao: ");

        if (scanf("%d", &opcao) != 1) {
            printf("\nEntrada invalida. Encerrando.\n");
            break;
        }

        /* delays em ms: exploracao mais rapida, caminho mais lento */
        if (opcao == 1 || opcao == 2) {
            resolverLabirinto(&original, &resultado);
            animarBusca(&original, &resultado, (opcao == 2) ? 1 : 0, 25, 130);
        } else if (opcao == 3 || opcao == 4) {
            resolverDijkstra(&original, &resultado);
            animarBusca(&original, &resultado, (opcao == 4) ? 1 : 0, 25, 130);
        } else if (opcao == 5) {
            mostrarEstatico();
        } else if (opcao != 0) {
            printf("\nOpcao invalida, tente novamente.\n");
        }
    }

    printf("\nPrograma encerrado.\n");
    return 0;
}
