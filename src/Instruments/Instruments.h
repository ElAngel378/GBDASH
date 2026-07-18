#ifndef INSTRUMENT_H
#define INSTRUMENT_H

#include <stdint.h>

typedef struct Instrument
{
    void (*trigger)(uint8_t channel, uint8_t pitch, uint8_t volume);
    void (*update)(uint8_t channel, uint8_t pitch, uint8_t volume);
    void (*step)(uint8_t channel);
    void (*init)(uint8_t channel);
    void (*override)(uint8_t channel, uint8_t flags); // 0: Duty, 1: Waveform //
    void (*release)(uint8_t channel);
} Instrument;

extern const Instrument * const instruments[];

#endif