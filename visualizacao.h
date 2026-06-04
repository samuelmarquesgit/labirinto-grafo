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

/* Anima a BFS: primeiro a exploracao (onda de visitados), depois o desenho
 * do menor caminho. Emite um som a cada no quando comAudio != 0.
 *   - delayBusca:   pausa (ms) entre cada no explorado.
 *   - delayCaminho: pausa (ms) entre cada passo do caminho final.
 */
void animarBusca(const Labirinto *lab, const Resultado *res,
                 int comAudio, int delayBusca, int delayCaminho);

#endif /* VISUALIZACAO_H */
