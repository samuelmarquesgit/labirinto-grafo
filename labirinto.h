/* ==========================================================================
 * labirinto.h - Nucleo da logica do labirinto (C ANSI puro)
 *
 * Aqui ficam apenas TIPOS e ASSINATURAS das funcoes. A implementacao esta
 * em labirinto.c. Nenhuma funcao deste modulo usa recursos fora do C ANSI
 * (nada de som, animacao ou bibliotecas do Windows).
 * ========================================================================== */
#ifndef LABIRINTO_H 
#define LABIRINTO_H

/* Tamanho maximo do labirinto. Aumente se for usar um labirinto maior. */
#define MAX_LINHAS  100
#define MAX_COLUNAS 200

/* Quantidade maxima de celulas (usada nos vetores auxiliares). */
#define MAX_CELULAS (MAX_LINHAS * MAX_COLUNAS)

/* --------------------------------------------------------------------------
 * Posicao: representa UM vertice do grafo (uma celula da matriz).
 * -------------------------------------------------------------------------- */
typedef struct {
    int linha;
    int coluna;
} Posicao;

/* --------------------------------------------------------------------------
 * Labirinto: a matriz de caracteres + suas dimensoes reais.
 * -------------------------------------------------------------------------- */
typedef struct {
    char grade[MAX_LINHAS][MAX_COLUNAS];
    int  numLinhas;
    int  numColunas;
} Labirinto;

/* --------------------------------------------------------------------------
 * Resultado: tudo o que a busca (BFS) produz.
 *   - existeCaminho: 1 se achou caminho, 0 caso contrario.
 *   - passos: numero de passos (arestas) do menor caminho.
 *   - caminho/tamanhoCaminho: a sequencia de posicoes da ENTRADA ate a SAIDA.
 *   - ordemVisita/totalVisitados: a ordem em que a BFS visitou as posicoes
 *     (usada para a animacao didatica).
 * -------------------------------------------------------------------------- */
typedef struct {
    int     existeCaminho;
    int     passos;
    Posicao caminho[MAX_CELULAS];
    int     tamanhoCaminho;
    Posicao ordemVisita[MAX_CELULAS];
    int     totalVisitados;
} Resultado;

/* Carrega um labirinto a partir de um vetor de strings. */
void carregarDoVetor(Labirinto *lab, const char *linhas[], int totalLinhas);

/* Exibe o labirinto na tela (linha por linha). */
void exibirLabirinto(const Labirinto *lab);

/* Procura o caractere alvo (ex.: 'E' ou 'S'). Devolve linha=-1 se nao achar. */
Posicao localizar(const Labirinto *lab, char alvo);

/* Diz se a posicao pode ser visitada (dentro dos limites e nao e' parede). */
int ehLivre(const Labirinto *lab, int linha, int coluna);

/* Executa a BFS e preenche 'res' com o menor caminho e a ordem de visita. */
void resolverLabirinto(const Labirinto *lab, Resultado *res);

/* Executa o algoritmo de Dijkstra (mesmo resultado da BFS, pois o peso e' 1).
 * Preenche 'res' do mesmo jeito que resolverLabirinto. */
void resolverDijkstra(const Labirinto *lab, Resultado *res);

/* Marca o caminho encontrado com '*' na grade (sem apagar 'E' e 'S'). */
void marcarCaminho(Labirinto *lab, const Resultado *res);

#endif /* LABIRINTO_H */
