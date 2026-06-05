/* ==========================================================================
 * testes.c - Bateria de testes do nucleo (C ANSI puro)
 *
 * Usa assert.h (parte do C ANSI). Cada assert verifica uma condicao; se ela
 * for falsa, o programa ABORTA e mostra o arquivo/linha do erro - assim voce
 * nunca entrega o codigo quebrado.
 *
 * Compile com: gcc -ansi -pedantic -Wall labirinto.c testes.c -o testes.exe
 * Rode com:    testes.exe   (no Windows)
 *
 * Nao inclui visualizacao.c de proposito: os testes checam apenas a LOGICA.
 * ========================================================================== */
#include <stdio.h>
#include <assert.h>
#include "labirinto.h"

/* Resultado grande fica fora da pilha. */
static Resultado res;

/* Labirinto pequeno COM caminho. Entrada (1,0), saida (3,4).
 * Menor caminho tem 6 passos (7 posicoes). */
static const char *MAPA_COM_CAMINHO[] = {
    "#####",
    "E...#",
    "#.#.#",
    "#...S",
    "#####"
};

/* Labirinto pequeno SEM caminho: a saida fica isolada por paredes. */
static const char *MAPA_SEM_CAMINHO[] = {
    "#####",
    "E...#",
    "#####",
    "#..S#",
    "#####"
};

/* ----- Teste 1: carregar e dimensoes ----- */
static void teste_carregar(void) {
    Labirinto lab;
    carregarDoVetor(&lab, MAPA_COM_CAMINHO, 5);
    assert(lab.numLinhas == 5);
    assert(lab.numColunas == 5);
    assert(lab.grade[0][0] == '#');
    assert(lab.grade[1][0] == 'E');
    printf("OK - carregar e dimensoes\n");
}

/* ----- Teste 2: localizar ----- */
static void teste_localizar(void) {
    Labirinto lab;
    Posicao e, s, x;
    carregarDoVetor(&lab, MAPA_COM_CAMINHO, 5);

    e = localizar(&lab, 'E');
    s = localizar(&lab, 'S');
    x = localizar(&lab, 'X'); /* nao existe */

    assert(e.linha == 1 && e.coluna == 0);
    assert(s.linha == 3 && s.coluna == 4);
    assert(x.linha == -1);
    printf("OK - localizar entrada/saida\n");
}

/* ----- Teste 3: ehLivre ----- */
static void teste_ehLivre(void) {
    Labirinto lab;
    carregarDoVetor(&lab, MAPA_COM_CAMINHO, 5);

    assert(ehLivre(&lab, 1, 1) == 1); /* caminho livre */
    assert(ehLivre(&lab, 0, 0) == 0); /* parede        */
    assert(ehLivre(&lab, 2, 2) == 0); /* parede no meio */
    assert(ehLivre(&lab, -1, 0) == 0); /* fora dos limites */
    assert(ehLivre(&lab, 1, 99) == 0); /* fora dos limites */
    printf("OK - ehLivre (limites e paredes)\n");
}

/* ----- Teste 4: menor caminho encontrado ----- */
static void teste_caminho(void) {
    Labirinto lab;
    Posicao inicio, fim;
    carregarDoVetor(&lab, MAPA_COM_CAMINHO, 5);

    resolverLabirinto(&lab, &res);

    assert(res.existeCaminho == 1);
    assert(res.passos == 6);          /* menor caminho tem 6 passos */
    assert(res.tamanhoCaminho == 7);  /* 6 passos => 7 posicoes     */

    inicio = res.caminho[0];
    fim = res.caminho[res.tamanhoCaminho - 1];
    assert(inicio.linha == 1 && inicio.coluna == 0); /* comeca na entrada */
    assert(fim.linha == 3 && fim.coluna == 4);       /* termina na saida  */

    printf("OK - menor caminho (passos = %d)\n", res.passos);
}

/* ----- Teste 5: caso sem caminho ----- */
static void teste_sem_caminho(void) {
    Labirinto lab;
    carregarDoVetor(&lab, MAPA_SEM_CAMINHO, 5);

    resolverLabirinto(&lab, &res);

    assert(res.existeCaminho == 0);
    assert(res.passos == 0);
    printf("OK - detecta ausencia de caminho\n");
}

/* ----- Teste 6: marcar caminho preserva E e S ----- */
static void teste_marcar(void) {
    Labirinto lab;
    carregarDoVetor(&lab, MAPA_COM_CAMINHO, 5);

    resolverLabirinto(&lab, &res);
    marcarCaminho(&lab, &res);

    /* a entrada e a saida nao podem virar '*' */
    assert(lab.grade[1][0] == 'E');
    assert(lab.grade[3][4] == 'S');
    /* alguma posicao do meio do caminho deve estar marcada */
    assert(lab.grade[res.caminho[1].linha][res.caminho[1].coluna] == '*');
    printf("OK - marcar caminho preserva E e S\n");
}

/* ----- Teste 7: Dijkstra acha o mesmo menor caminho que a BFS ----- */
static void teste_dijkstra(void) {
    Labirinto lab;
    carregarDoVetor(&lab, MAPA_COM_CAMINHO, 5);

    resolverDijkstra(&lab, &res);

    assert(res.existeCaminho == 1);
    assert(res.passos == 6);          /* mesmo resultado da BFS */
    assert(res.tamanhoCaminho == 7);
    printf("OK - Dijkstra (passos = %d, igual a BFS)\n", res.passos);
}

/* ----- Teste 8: Dijkstra tambem detecta ausencia de caminho ----- */
static void teste_dijkstra_sem_caminho(void) {
    Labirinto lab;
    carregarDoVetor(&lab, MAPA_SEM_CAMINHO, 5);

    resolverDijkstra(&lab, &res);

    assert(res.existeCaminho == 0);
    printf("OK - Dijkstra detecta ausencia de caminho\n");
}

int main(void) {
    printf("Iniciando testes...\n\n");

    teste_carregar();
    teste_localizar();
    teste_ehLivre();
    teste_caminho();
    teste_sem_caminho();
    teste_marcar();
    teste_dijkstra();
    teste_dijkstra_sem_caminho();

    printf("\n========================================\n");
    printf(" TODOS OS TESTES PASSARAM COM SUCESSO!\n");
    printf("========================================\n");
    return 0;
}
