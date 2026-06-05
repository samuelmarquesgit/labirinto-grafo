/* ==========================================================================
 * teste-som.c - Teste isolado de audio (so para diagnosticar o Beep)
 *
 * Compile:  gcc teste-som.c -o teste-som.exe
 * Rode:     teste-som.exe
 *
 * Se voce OUVIR os bips, o audio funciona e o problema esta na animacao.
 * Se NAO ouvir nada, o problema e' o ambiente (terminal/volume/driver).
 * ========================================================================== */
#include <stdio.h>

#ifdef _WIN32
#include <windows.h>
#endif

int main(void) {
    int i;
    int notas[8] = { 262, 294, 330, 349, 392, 440, 494, 523 }; /* do re mi... */

    printf("Teste 1: bell do terminal (\\a). Voce deve ouvir um 'ding'.\n");
    printf("\a");
    fflush(stdout);

#ifdef _WIN32
    Sleep(1000);

    printf("Teste 2: um bip longo de 1 segundo (440 Hz)...\n");
    Beep(440, 1000);

    printf("Teste 3: uma escala musical (8 notas)...\n");
    for (i = 0; i < 8; i++) {
        printf("  nota %d (%d Hz)\n", i + 1, notas[i]);
        Beep(notas[i], 350);
    }

    printf("\nFim. Voce ouviu os bips dos testes 2 e 3? (s/n)\n");
#else
    (void)i;
    (void)notas;
    printf("Beep so funciona no Windows.\n");
#endif

    return 0;
}
