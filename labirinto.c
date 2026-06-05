/* ==========================================================================
 * labirinto.c - Implementacao da logica do labirinto (C ANSI puro / C89)
 *
 * Modelagem como grafo: 
 *   - cada celula livre ('.', 'E', 'S') e' um VERTICE;
 *   - cada par de celulas livres vizinhas (cima/baixo/esquerda/direita) e'
 *     ligado por uma ARESTA;
 *   - as paredes '#' nao sao vertices;
 *   - como cada movimento custa 1, a BFS encontra o MENOR caminho.
 *
 * Compile este arquivo com: gcc -ansi -pedantic -Wall ...
 * ========================================================================== */
#include <stdio.h>
#include "labirinto.h"

/* Os 4 movimentos validos: cima, baixo, esquerda, direita (sem diagonais). */
static const int deslocaLinha[4]  = { -1,  1,  0,  0 };
static const int deslocaColuna[4] = {  0,  0, -1,  1 };

/* --------------------------------------------------------------------------
 * carregarDoVetor
 * Copia cada string do vetor 'linhas' para a matriz do labirinto.
 * Tambem calcula numLinhas e a maior largura (numColunas).
 * -------------------------------------------------------------------------- */
void carregarDoVetor(Labirinto *lab, const char *linhas[], int totalLinhas) {
    int i, j;

    lab->numLinhas = totalLinhas;
    lab->numColunas = 0;

    for (i = 0; i < totalLinhas; i++) {
        j = 0;
        while (linhas[i][j] != '\0') {
            lab->grade[i][j] = linhas[i][j];
            j++;
        }
        lab->grade[i][j] = '\0';     /* fecha a string da linha */
        if (j > lab->numColunas) {
            lab->numColunas = j;
        }
    }
}

/* --------------------------------------------------------------------------
 * exibirLabirinto
 * -------------------------------------------------------------------------- */
void exibirLabirinto(const Labirinto *lab) {
    int i;
    for (i = 0; i < lab->numLinhas; i++) {
        printf("%s\n", lab->grade[i]);
    }
}

/* --------------------------------------------------------------------------
 * localizar
 * Procura 'alvo' na matriz. Devolve a posicao, ou linha=-1 se nao achar.
 * -------------------------------------------------------------------------- */
Posicao localizar(const Labirinto *lab, char alvo) {
    Posicao p;
    int i, j;

    p.linha = -1;
    p.coluna = -1;

    for (i = 0; i < lab->numLinhas; i++) {
        for (j = 0; j < lab->numColunas; j++) {
            if (lab->grade[i][j] == alvo) {
                p.linha = i;
                p.coluna = j;
                return p;
            }
        }
    }
    return p;
}

/* --------------------------------------------------------------------------
 * ehLivre
 * 1 se a posicao esta dentro dos limites e nao e' parede; 0 caso contrario.
 * -------------------------------------------------------------------------- */
int ehLivre(const Labirinto *lab, int linha, int coluna) {
    if (linha < 0 || linha >= lab->numLinhas) {
        return 0;
    }
    if (coluna < 0 || coluna >= lab->numColunas) {
        return 0;
    }
    if (lab->grade[linha][coluna] == '#') {
        return 0;
    }
    return 1;
}

/* --------------------------------------------------------------------------
 * resolverLabirinto  (BFS - Busca em Largura)
 *
 * Preenche 'res' com:
 *   - se existe caminho;
 *   - o menor caminho (entrada -> saida) e o numero de passos;
 *   - a ordem em que as posicoes foram visitadas (para a animacao).
 *
 * As matrizes auxiliares sao 'static' para nao estourar a pilha em
 * labirintos grandes.
 * -------------------------------------------------------------------------- */
void resolverLabirinto(const Labirinto *lab, Resultado *res) {
    static int     visitado[MAX_LINHAS][MAX_COLUNAS];
    static Posicao pai[MAX_LINHAS][MAX_COLUNAS];
    static Posicao fila[MAX_CELULAS];
    static Posicao reverso[MAX_CELULAS];

    int inicio = 0;
    int fim = 0;
    int i, j, d;
    int achou = 0;
    int qtd = 0;
    Posicao entrada, saida, atual, vizinho, passo;

    /* Estado inicial do resultado */
    res->existeCaminho = 0;
    res->passos = 0;
    res->tamanhoCaminho = 0;
    res->totalVisitados = 0;

    entrada = localizar(lab, 'E');
    saida   = localizar(lab, 'S');

    /* Sem entrada ou sem saida: nada a fazer */
    if (entrada.linha == -1 || saida.linha == -1) {
        return;
    }

    /* Zera o controle de visitados */
    for (i = 0; i < lab->numLinhas; i++) {
        for (j = 0; j < lab->numColunas; j++) {
            visitado[i][j] = 0;
        }
    }

    /* Coloca a entrada na fila */
    visitado[entrada.linha][entrada.coluna] = 1; 
    pai[entrada.linha][entrada.coluna] = entrada;
    fila[fim] = entrada;
    fim++;
    res->ordemVisita[res->totalVisitados] = entrada;
    res->totalVisitados++;

    /* Laco principal da BFS */
    while (inicio < fim) {
        atual = fila[inicio];
        inicio++;

        if (atual.linha == saida.linha && atual.coluna == saida.coluna) {
            achou = 1;
            break;
        }

        for (d = 0; d < 4; d++) {
            vizinho.linha  = atual.linha  + deslocaLinha[d];
            vizinho.coluna = atual.coluna + deslocaColuna[d];

            if (ehLivre(lab, vizinho.linha, vizinho.coluna) &&
                !visitado[vizinho.linha][vizinho.coluna]) {

                visitado[vizinho.linha][vizinho.coluna] = 1;
                pai[vizinho.linha][vizinho.coluna] = atual;
                fila[fim] = vizinho;
                fim++;
                res->ordemVisita[res->totalVisitados] = vizinho;
                res->totalVisitados++;
            }
        }
    }

    if (!achou) {
        return; /* existeCaminho continua 0 */
    }

    /* Reconstrucao: da saida ate a entrada, seguindo os 'pais' */
    res->existeCaminho = 1;
    passo = saida;
    qtd = 0;
    while (!(passo.linha == entrada.linha && passo.coluna == entrada.coluna)) {
        reverso[qtd] = passo;
        qtd++;
        passo = pai[passo.linha][passo.coluna];
    }
    reverso[qtd] = entrada;
    qtd++;

    /* Inverte para que caminho[0] seja a ENTRADA */
    for (i = 0; i < qtd; i++) {
        res->caminho[i] = reverso[qtd - 1 - i];
    }
    res->tamanhoCaminho = qtd;
    res->passos = qtd - 1; /* numero de movimentos (arestas) */
}

/* --------------------------------------------------------------------------
 * resolverDijkstra  (Algoritmo de Dijkstra)
 *
 * Encontra o menor caminho usando distancias. Como TODA aresta tem peso 1,
 * o resultado e' o mesmo da BFS - a diferenca e' o metodo:
 *   - mantem uma distancia (dist) para cada posicao, comecando em "infinito";
 *   - a cada passo, escolhe a posicao NAO visitada de MENOR distancia;
 *   - atualiza (relaxa) a distancia dos vizinhos: dist[atual] + 1.
 *
 * Esta versao usa selecao linear do minimo (sem fila de prioridade), o que e'
 * simples e suficiente para o tamanho deste labirinto.
 * -------------------------------------------------------------------------- */
void resolverDijkstra(const Labirinto *lab, Resultado *res) {
    static int     dist[MAX_LINHAS][MAX_COLUNAS];
    static int     visitado[MAX_LINHAS][MAX_COLUNAS];
    static Posicao pai[MAX_LINHAS][MAX_COLUNAS];
    static Posicao reverso[MAX_CELULAS];

    const int INFINITO = 1000000000;
    int i, j, d;
    int achou = 0;
    int qtd = 0;
    int menorDist, melhorI, melhorJ, novaDist;
    Posicao entrada, saida, atual, vizinho, passo;

    res->existeCaminho = 0;
    res->passos = 0;
    res->tamanhoCaminho = 0;
    res->totalVisitados = 0;

    entrada = localizar(lab, 'E');
    saida   = localizar(lab, 'S');
    if (entrada.linha == -1 || saida.linha == -1) {
        return;
    }

    /* Toda posicao comeca com distancia "infinita" e nao visitada */
    for (i = 0; i < lab->numLinhas; i++) {
        for (j = 0; j < lab->numColunas; j++) {
            dist[i][j] = INFINITO;
            visitado[i][j] = 0;
        }
    }
    dist[entrada.linha][entrada.coluna] = 0;
    pai[entrada.linha][entrada.coluna] = entrada;

    while (1) {
        /* 1) escolhe a posicao livre, nao visitada, de MENOR distancia */
        menorDist = INFINITO;
        melhorI = -1;
        melhorJ = -1;
        for (i = 0; i < lab->numLinhas; i++) {
            for (j = 0; j < lab->numColunas; j++) {
                if (!visitado[i][j] && ehLivre(lab, i, j) &&
                    dist[i][j] < menorDist) {
                    menorDist = dist[i][j];
                    melhorI = i;
                    melhorJ = j;
                }
            }
        }

        /* nao sobrou nenhuma posicao alcancavel */
        if (melhorI == -1) {
            break;
        }

        atual.linha = melhorI;
        atual.coluna = melhorJ;
        visitado[melhorI][melhorJ] = 1;
        res->ordemVisita[res->totalVisitados] = atual;
        res->totalVisitados++;

        if (atual.linha == saida.linha && atual.coluna == saida.coluna) {
            achou = 1;
            break;
        }

        /* 2) relaxa os 4 vizinhos (peso de cada aresta = 1) */
        for (d = 0; d < 4; d++) {
            vizinho.linha  = melhorI + deslocaLinha[d];
            vizinho.coluna = melhorJ + deslocaColuna[d];

            if (ehLivre(lab, vizinho.linha, vizinho.coluna) &&
                !visitado[vizinho.linha][vizinho.coluna]) {

                novaDist = dist[melhorI][melhorJ] + 1;
                if (novaDist < dist[vizinho.linha][vizinho.coluna]) {
                    dist[vizinho.linha][vizinho.coluna] = novaDist;
                    pai[vizinho.linha][vizinho.coluna] = atual;
                }
            }
        }
    }

    if (!achou) {
        return;
    }

    /* Reconstrucao identica a da BFS */
    res->existeCaminho = 1;
    passo = saida;
    qtd = 0;
    while (!(passo.linha == entrada.linha && passo.coluna == entrada.coluna)) {
        reverso[qtd] = passo;
        qtd++;
        passo = pai[passo.linha][passo.coluna];
    }
    reverso[qtd] = entrada;
    qtd++;

    for (i = 0; i < qtd; i++) {
        res->caminho[i] = reverso[qtd - 1 - i];
    }
    res->tamanhoCaminho = qtd;
    res->passos = qtd - 1;
}

/* --------------------------------------------------------------------------
 * marcarCaminho
 * Escreve '*' nas posicoes do caminho, preservando 'E' e 'S'.
 * -------------------------------------------------------------------------- */
void marcarCaminho(Labirinto *lab, const Resultado *res) {
    int i;
    Posicao p;

    for (i = 0; i < res->tamanhoCaminho; i++) {
        p = res->caminho[i];
        if (lab->grade[p.linha][p.coluna] != 'E' &&
            lab->grade[p.linha][p.coluna] != 'S') {
            lab->grade[p.linha][p.coluna] = '*';
        }
    }
}
