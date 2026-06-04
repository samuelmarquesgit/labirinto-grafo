/* ==========================================================================
 * visualizacao.c - Animacao + audio (Windows)
 *
 * Usa windows.h (Beep, Sleep, API do console). Compile SEM -ansi -pedantic,
 * pois windows.h nao e' C ANSI. Em outros sistemas, cai num modo simples
 * (sem som/animacao real), so para nao quebrar a compilacao.
 *
 * IMPORTANTE: para evitar o "piscar" e o audio picotado, NAO usamos
 * system("cls") a cada quadro (isso abre um cmd.exe toda vez e trava tudo,
 * inclusive o som). Em vez disso, limpamos a tela UMA vez e, a cada quadro,
 * apenas movemos o cursor de volta ao topo e redesenhamos por cima.
 * ========================================================================== */
#include <stdio.h>
#include <stdlib.h>
#include "visualizacao.h"

#ifdef _WIN32
#include <windows.h>
#endif

/* Emite um som a cada N nos explorados (em vez de em todos). Isso cria a
 * "ilusao" de bip continuo e evita o audio picotado. Teste com 2 ou 3. */
#define INTERVALO_SOM 3

/* Limpa a tela do console por completo (usada UMA vez no inicio). */
static void limparTela(void) {
#ifdef _WIN32
    system("cls");
#else
    system("clear");
#endif
}

/* Move o cursor de volta para o canto superior esquerdo (sem limpar). */
static void irParaTopo(void) {
#ifdef _WIN32
    HANDLE saida = GetStdHandle(STD_OUTPUT_HANDLE);
    COORD topo;
    topo.X = 0;
    topo.Y = 0;
    SetConsoleCursorPosition(saida, topo);
#endif
}

/* Mostra/esconde o cursor (esconder deixa a animacao mais limpa). */
static void cursorVisivel(int visivel) {
#ifdef _WIN32
    HANDLE saida = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_CURSOR_INFO info;
    GetConsoleCursorInfo(saida, &info);
    info.bVisible = visivel ? TRUE : FALSE;
    SetConsoleCursorInfo(saida, &info);
#else
    (void)visivel;
#endif
}

/* Pausa por 'ms' milissegundos. */
static void esperar(int ms) {
#ifdef _WIN32
    Sleep(ms);
#else
    (void)ms; /* sem pausa fora do Windows */
#endif
}

/* Emite um som de frequencia 'freq' (Hz) por 'ms' milissegundos.
 * O Beep e' bloqueante (trava o programa enquanto toca), entao a duracao
 * do som tambem serve de "pausa" entre os quadros. Usado nos sons finais. */
static void bip(int freq, int ms) {
#ifdef _WIN32
    Beep(freq, ms);
#else
    (void)freq;
    (void)ms;
    printf("\a"); /* "bell" do terminal, como alternativa */
#endif
}

#ifdef _WIN32
/* Parametros passados para a thread de audio. */
typedef struct {
    int freq;
    int ms;
} ParamBip;

/* Funcao executada na thread de fundo: toca o som e libera a memoria. */
static DWORD WINAPI threadBip(LPVOID arg) {
    ParamBip *p = (ParamBip *)arg;
    Beep(p->freq, p->ms);
    free(p);
    return 0;
}
#endif

/* Toca um som SEM travar o programa: dispara o Beep numa thread separada,
 * para que a animacao continue desenhando enquanto o som toca. */
static void bipAssincrono(int freq, int ms) {
#ifdef _WIN32
    ParamBip *p;
    HANDLE h;
    p = (ParamBip *)malloc(sizeof(ParamBip));
    if (p == NULL) {
        return;
    }
    p->freq = freq;
    p->ms = ms;
    h = CreateThread(NULL, 0, threadBip, p, 0, NULL);
    if (h != NULL) {
        CloseHandle(h); /* a thread se encerra sozinha ao terminar o Beep */
    } else {
        free(p);
    }
#else
    (void)freq;
    (void)ms;
    printf("\a");
#endif
}

/* Imprime o cabecalho/legenda comum dos quadros da animacao. */
static void cabecalho(const char *titulo) {
    printf("%s\n", titulo);
    printf("Legenda:  E=entrada  S=saida  #=parede  :=visitado  *=caminho\n\n");
}

/* --------------------------------------------------------------------------
 * animarBusca
 * -------------------------------------------------------------------------- */
void animarBusca(const Labirinto *lab, const Resultado *res,
                 int comAudio, int delayBusca, int delayCaminho) {
    Labirinto trabalho;   /* copia de trabalho para ir marcando a tela */
    int i;
    int freq;
    Posicao p;

    trabalho = *lab; /* copia a grade original */

    if (!res->existeCaminho) {
        limparTela();
        cabecalho("Nao foi possivel resolver:");
        exibirLabirinto(lab);
        printf("\nNao existe caminho entre a entrada e a saida.\n");
        if (comAudio) {
            bip(200, 250); /* som grave de "erro" */
            bip(150, 400);
        }
        return;
    }

    cursorVisivel(0);
    limparTela(); /* limpa UMA vez; depois so reposicionamos o cursor */

    /* ----- Fase 1: animar a EXPLORACAO (a onda da busca) ----- */
    for (i = 0; i < res->totalVisitados; i++) {
        p = res->ordemVisita[i];

        /* marca como visitado, sem apagar entrada/saida */
        if (trabalho.grade[p.linha][p.coluna] == '.') {
            trabalho.grade[p.linha][p.coluna] = ':';
        }

        irParaTopo();
        cabecalho("Explorando o labirinto (busca pelo menor caminho)...");
        exibirLabirinto(&trabalho);
        printf("\nVisitados: %d de %d   \n", i + 1, res->totalVisitados);

        /* Som a cada INTERVALO_SOM nos, tocado em paralelo (thread): a
         * animacao continua desenhando enquanto a nota soa, sem cortar. */
        if (comAudio && (i % INTERVALO_SOM == 0)) {
            freq = 250 + (i * 7) % 700;
            bipAssincrono(freq, 150);
        }
        /* a pausa do desenho e' sempre a mesma, deixando o ritmo suave */
        esperar(delayBusca);
    }

    /* ----- Fase 2: animar o MENOR CAMINHO sendo desenhado ----- */
    for (i = 0; i < res->tamanhoCaminho; i++) {
        p = res->caminho[i];

        if (trabalho.grade[p.linha][p.coluna] != 'E' &&
            trabalho.grade[p.linha][p.coluna] != 'S') {
            trabalho.grade[p.linha][p.coluna] = '*';
        }

        irParaTopo();
        cabecalho("Reconstruindo o MENOR caminho (entrada -> saida)...");
        exibirLabirinto(&trabalho);
        printf("\nPasso %d de %d   \n", i, res->tamanhoCaminho - 1);

        /* tom subindo SUAVEMENTE a cada passo (incremento pequeno) e com teto
         * baixo, para nao virar um agudo estridente/inaudivel. */
        if (comAudio) {
            freq = 250 + i * 2;
            if (freq > 1000) {
                freq = 1000;
            }
            bipAssincrono(freq, 110);
        }
        /* a pausa do desenho mantem o ritmo, com ou sem audio */
        esperar(delayCaminho);
    }

    cursorVisivel(1);
    printf("\n>>> Caminho encontrado! Quantidade de passos: %d\n", res->passos);
    if (comAudio) {
        bip(880, 120); /* pequena "fanfarra" final */
        bip(1175, 120);
        bip(1568, 250);
    }
}
