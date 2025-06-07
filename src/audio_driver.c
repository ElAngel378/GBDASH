#include "audio_driver.h"
#include <stdint.h>
#define REG(addr) (*(volatile unsigned char *)(addr))

static int freq_to_timer(int freq_hz, char iswave)
{
    if (iswave)
    {
        if (freq_hz <= 0)
            return 2047; // silence
        int timer = (int)2048 - (131072 / (freq_hz*2));
        if (timer < 0)
            timer = 0;
        if (timer > 2047)
            timer = 2047;
        return timer;
    }
    else
    {
        if (freq_hz <= 0)
            return 2047; // silence
        int timer = (int)2048 - (131072 / freq_hz);
        if (timer < 0)
            timer = 0;
        if (timer > 2047)
            timer = 2047;
        return timer;
    }
}

void setenable(char enable)
{
    if (enable)
    {
        REG(0xFF26) |= 0b10000000;
    }
    else
    {
        REG(0xFF26) &= ~0b10000000;
    }
}

void setmastervolume(char left, char right)
{
    // Keep bits 7 and 3, set left volume (bits 4-6), right volume (bits 0-2)
    REG(0xFF24) = (REG(0xFF24) & 0b10001000) |
                  ((left & 0b111) << 4) |
                  (right & 0b111);
}

void setpan(Sound_Channel channel, Channel pan)
{
    REG(0xFF25) &= ~(0b00010001 << channel);
    REG(0xFF25) |= (pan << channel);
}

void setfreq(Sound_Channel channel, int freq_hz)
{
    int timer = freq_to_timer(freq_hz,(channel == SOUND_WAVE));
    switch (channel)
    {
    case 0:
        REG(0xFF13) = timer & 0xFF;                                 // NR13 - freq low bits
        REG(0xFF14) = (REG(0xFF14) & 0xF8) | ((timer >> 8) & 0x07); // NR14 bits 0-2 freq high bits
        break;
    case 1:
        REG(0xFF18) = timer & 0xFF;                                 // NR23 - freq low bits
        REG(0xFF19) = (REG(0xFF19) & 0xF8) | ((timer >> 8) & 0x07); // NR24 bits 0-2 freq high bits
        break;
    case 2:
        REG(0xFF1D) = timer & 0xFF;                                 // NR33 - freq low bits
        REG(0xFF1E) = (REG(0xFF1E) & 0xF8) | ((timer >> 8) & 0x07); // NR34 bits 0-2 freq high bits
        break;
    default:
        // unsupported channel
        break;
    }
}

void setpitch(Sound_Channel channel, int timer)
{
    switch (channel)
    {
    case 0:
        REG(0xFF13) = timer & 0xFF;                                 // NR13 - freq low bits
        REG(0xFF14) = (REG(0xFF14) & 0xF8) | ((timer >> 8) & 0x07); // NR14 bits 0-2 freq high bits
        break;
    case 1:
        REG(0xFF18) = timer & 0xFF;                                 // NR23 - freq low bits
        REG(0xFF19) = (REG(0xFF19) & 0xF8) | ((timer >> 8) & 0x07); // NR24 bits 0-2 freq high bits
        break;
    case 2:
        REG(0xFF1D) = timer & 0xFF;                                 // NR33 - freq low bits
        REG(0xFF1E) = (REG(0xFF1E) & 0xF8) | ((timer >> 8) & 0x07); // NR34 bits 0-2 freq high bits
        break;
    default:
        // unsupported channel
        break;
    }
}

void setenvolope(Sound_Channel channel, char direction, char vol, char period)
{
    switch (channel)
    {
    case SOUND_PULSE1:
        REG(0xFF12) = (vol & 0b1111) << 4 | (direction & 0b1) << 3 | period & 0b111;
        break;

    case SOUND_PULSE2:
        REG(0xFF17) = (vol & 0b1111) << 4 | (direction & 0b1) << 3 | period & 0b111;
        break;

    case SOUND_NOISE:
        REG(0xFF21) = (vol & 0b1111) << 4 | (direction & 0b1) << 3 | period & 0b111;
        break;

    default:
        break;
    }
}

void setlengthandduty(Sound_Channel channel, char length, char duty)
{
    switch (channel)
    {
    case SOUND_PULSE1:
        // NR11 (0xFF11): Duty (bits 6–7), Length (bits 0–5)
        REG(0xFF11) = ((duty & 0b11) << 6) | (length & 0b111111);
        break;

    case SOUND_PULSE2:
        // NR21 (0xFF16): Duty (bits 6–7), Length (bits 0–5)
        REG(0xFF16) = ((duty & 0b11) << 6) | (length & 0b111111);
        break;

    case SOUND_WAVE:
        // NR31 (0xFF1B): Only Length (entire 8 bits); no duty
        REG(0xFF1B) = length;
        break;

    case SOUND_NOISE:
        // NR41 (0xFF20): Only Length (6 bits)
        REG(0xFF20) = length & 0b111111;
        break;

    default:
        break;
    }
}

void setsweep(Sweep_Dir dir, char shift, char period)
{
    REG(0xFF10) = ((period & 0b111) << 4) | ((dir & 0b1) << 3) | (shift & 0b111);
}

void setvolume(Sound_Channel channel, char volume)
{
    switch (channel)
    {
    case SOUND_PULSE1:
    {
        // NR12: bits 4-7 = initial volume, bits 0-3 = envelope settings
        uint8_t current = REG(0xFF12);
        current = (current & 0x0F) | ((volume & 0x0F) << 4); // Preserve bits 0–3
        REG(0xFF12) = current;
        break;
    }

    case SOUND_PULSE2:
    {
        // NR22
        uint8_t current = REG(0xFF17);
        current = (current & 0x0F) | ((volume & 0x0F) << 4);
        REG(0xFF17) = current;
        break;
    }

    case SOUND_WAVE:
    {
        // NR32: bits 5-6 control output level; only 2 bits used
        uint8_t current = REG(0xFF1C);
        current = (current & 0x9F) | ((volume & 0x03) << 5); // Preserve bits 0–4 and 7
        REG(0xFF1C) = current;
        break;
    }

    case SOUND_NOISE:
    {
        // NR42
        uint8_t current = REG(0xFF21);
        current = (current & 0x0F) | ((volume & 0x0F) << 4);
        REG(0xFF21) = current;
        break;
    }

    default:
        break;
    }
}

int _i = 0;
void setwave(const unsigned char *samples_4bit)
{
    REG(0xFF1A) = 0;
    for (_i = 0; _i < 16; _i++)
    {
        // Each byte holds two 4-bit samples
        unsigned char high = samples_4bit[_i * 2] & 0x0F;    // First sample (high nibble)
        unsigned char low = samples_4bit[_i * 2 + 1] & 0x0F; // Second sample (low nibble)
        unsigned char packed = (high << 4) | low;

        REG(0xFF30 + _i) = packed;
    }
    REG(0xFF1A) = 0b10000000;
}

void panic_sound(void) {
    // Power off sound hardware
    REG(0xFF26) = 0x00;

    // Pulse 1
    REG(0xFF10) = 0x00; // Sweep
    REG(0xFF11) = 0x00; // Duty/Length
    REG(0xFF12) = 0x00; // Envelope
    REG(0xFF13) = 0x00; // Frequency low
    REG(0xFF14) = 0x00; // Frequency high

    // Pulse 2
    REG(0xFF16) = 0x00; // Duty/Length
    REG(0xFF17) = 0x00; // Envelope
    REG(0xFF18) = 0x00; // Frequency low
    REG(0xFF19) = 0x00; // Frequency high

    // Wave channel
    REG(0xFF1A) = 0x00; // Sound ON/OFF
    REG(0xFF1B) = 0x00; // Length
    REG(0xFF1C) = 0x00; // Volume
    REG(0xFF1D) = 0x00; // Frequency low
    REG(0xFF1E) = 0x00; // Frequency high

    // Noise channel
    REG(0xFF20) = 0x00; // Length
    REG(0xFF21) = 0x00; // Envelope
    REG(0xFF22) = 0x00; // Polynomial counter
    REG(0xFF23) = 0x00; // Frequency/trigger
}
