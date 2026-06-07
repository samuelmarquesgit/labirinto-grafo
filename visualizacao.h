/* ==========================================================================
 * visualizacao.h - Animacao passo a passo + audio (especifico do Windows)
 *
 * ATENCAO: este modulo NAO e' C ANSI puro. Ele usa Beep/Sleep do windows.h
 * para tornar a execucao didatica (som a cada no e desenho dinamico). O
 * nucleo da logica (labirinto.c) continua 100% ANSI.
 * ========================================================================== */
#ifndef VISUALIZACAO_H
#define VISUALIZACAO_H

#include "labirinto.h"

/* ==========================================================================
 * CORES DO CONSOLE
 * ========================================================================== */
#define COR_PADRAO    7   /* Branco */
#define COR_VERMELHO  12  /* Vermelho intenso */
#define COR_VERDE     10  /* Verde intenso */
#define COR_AZUL      9   /* Azul intenso */
#define COR_AMARELO   14  /* Amarelo */

/* Define a cor do proximo texto a ser impresso.
 * cor: COR_VERMELHO, COR_VERDE, COR_AZUL, COR_AMARELO, COR_PADRAO
 */
void definirCor(int cor);

/* Restaura a cor padrao (branco) */
void restaurarCor(void);

/* Anima a BFS: primeiro a exploracao (onda de visitados), depois o desenho
 * do menor caminho. Emite um som a cada no quando comAudio != 0.
 *   - delayBusca:   pausa (ms) entre cada no explorado.
 *   - delayCaminho: pausa (ms) entre cada passo do caminho final.
 *
 * CORES USADAS:
 *   - E (entrada): VERMELHO
 *   - S (saida):   VERDE
 *   - : (visitado durante busca): VERMELHO
 *   - * (durante reconstrucao): AZUL
 *   - * (caminho final): VERDE
 */
void animarBusca(const Labirinto *lab, const Resultado *res,
                 int comAudio, int delayBusca, int delayCaminho);

#endif /* VISUALIZACAO_H */
