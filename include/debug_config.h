#ifndef DEBUG_CONFIG_H
#define DEBUG_CONFIG_H

/*
 * DEBUG MODE SWITCH
 * -----------------
 * 1 = debug mode can be turned on in the game: pause (START) and press B.
 *     While on: noclip (you can't die) and a scanline readout is drawn in the top right
 *     corner ("DBG", the scanline the game logic had finished at, and the worst one so far).
 *     The pause menu is then left with START (or A on PLAY) instead of B.
 * 0 = debug mode is compiled out completely (no code, no data, B resumes the game again).
 *
 * Set this to 0 before making a release build. It can also be overridden on the command line:
 *   make EXTRA=...   or   lcc -DENABLE_DEBUG_MODE=0
 */
#ifndef ENABLE_DEBUG_MODE
#define ENABLE_DEBUG_MODE 1
#endif

#endif /* DEBUG_CONFIG_H */
