#include "Engine.h"

typedef union {
    struct {
        uint8_t frac;
        uint8_t note;
        
    } fixed;

    uint16_t period;
} pitch;

uint16_t C1Stack[16];
uint8_t C1SP = 16;
uint16_t C2Stack[16];
uint8_t C2SP = 16;
uint16_t C3Stack[16];
uint8_t C3SP = 16;
uint16_t C4Stack[16];
uint8_t C4SP = 16;

uint16_t freqtable[12];

// 2^(n/12) * 256
const uint16_t semitoneRatio[12] = {
    256, 271, 287, 304, 322, 341,
    361, 383, 406, 430, 456, 483
};

int16_t deltaTable[12] = {
    16, 16, 18, 18, 20, 20,
    22, 24, 25, 26, 27, 0
};

uint16_t notetofreq(uint16_t note87)
{
    uint8_t frac = note87 & 0x7F;
    uint16_t note = note87 >> 7;

    uint8_t octave = note / 12;
    uint8_t key = note % 12;

    uint32_t freq;

    // get C4-B4 table value
    freq = freqtable[key];

    // interpolate to next note
    freq += ((int32_t)deltaTable[key] * frac) >> 7;

    // table is octave 4
    int8_t shift = octave - 4;

    if (shift > 0)
        freq <<= shift;
    else if (shift < 0)
        freq >>= -shift;

    return (uint16_t)freq;
}

uint16_t freqtoperiod(uint16_t freq) {
    return 2048 - (131072UL / freq);
}

uint16_t notetofreq(uint16_t note87)
{
    uint8_t frac = note87 & 0x7F;
    uint16_t note = note87 >> 7;

    uint8_t octave = note / 12;
    uint8_t key = note % 12;

    uint32_t freq;

    // get C4-B4 table value
    freq = freqtable[key];

    // interpolate to next note
    freq += ((int32_t)deltaTable[key] * frac) >> 7;

    // table is octave 4
    int8_t shift = octave - 4;

    if (shift > 0)
        freq <<= shift;
    else if (shift < 0)
        freq >>= -shift;

    return (uint16_t)freq;
}