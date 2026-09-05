#ifndef SAMPLE_PLAYER_H
#define SAMPLE_PLAYER_H

#include <gb/gb.h>

extern volatile uint8_t sample_playing;

void sample_play_isr(void) __nonbanked;
void play_sample(uint8_t bank, const uint8_t *sample, uint16_t length);
uint8_t is_sample_playing(void);
void stop_sample(void);

#endif
