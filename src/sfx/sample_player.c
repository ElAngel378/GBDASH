#include <gb/gb.h>
#include <gb/hardware.h>
#include "sample_player.h"

volatile uint8_t sample_playing = 0;
static uint8_t play_bank = 0;
static const uint8_t *play_sample_ptr = 0;
static uint16_t play_length = 0;

void sample_play_isr(void) __nonbanked __naked {
    __asm
        push af
        push bc
        push de
        push hl

        ld hl, #_play_length    ; something left to play?
        ld a, (hl+)
        or (hl)
        jr nz, 1$
        ; Already finished
        xor a
        ld (#_sample_playing), a
        ldh (_NR30_REG), a       ; Disable CH3
        ldh (_TAC_REG), a        ; Stop timer
        pop hl
        pop de
        pop bc
        pop af
        ret

1$:
        ld hl, #_play_sample_ptr
        ld a, (hl+)
        ld h, (hl)
        ld l, a                 ; HL = current position inside the sample

        ; Save current bank and switch to sample bank
        ld a, (#__current_bank)
        ld e, a
        ld a, (#_play_bank)
        ld (#__current_bank), a
        ld (_rROMB0), a

        ; Turn off CH3 to access wave RAM
        xor a
        ldh (_NR30_REG), a       

        .irp ofs,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
            ld a, (hl+)
            ldh (__AUD3WAVERAM+ofs), a
        .endm

        ; Turn CH3 back on
        ld a, #0x80             ; Enable CH3 DAC
        ldh (_NR30_REG), a
        ld a, #0x20             ; Volume (100%)
        ldh (_NR32_REG), a
        xor a                   ; Low freq bits = 0
        ldh (_NR33_REG), a
        ld a, #0x87             ; Trigger playback with freq high bits = 7 (freq 0x700 = 8192 Hz), continuous (no length counter)
        ldh (_NR34_REG), a       

        ; Restore bank
        ld a, e
        ld (#__current_bank), a
        ld (_rROMB0), a

        ; Save updated sample pointer
        ld a, l
        ld (#_play_sample_ptr), a
        ld a, h
        ld (#_play_sample_ptr+1), a

        ; Decrement play_length
        ld hl, #_play_length
        ld a, (hl)
        sub #1
        ld (hl+), a
        ld a, (hl)
        sbc #0
        ld (hl), a
        jr nz, 2$

        ; Just finished playing last block!
        xor a
        ld (#_sample_playing), a
        ldh (_NR30_REG), a       ; Disable CH3
        ldh (_TAC_REG), a        ; Stop timer

2$:
        pop hl
        pop de
        pop bc
        pop af
        ret
    __endasm;
}

void play_sample(uint8_t bank, const uint8_t *sample, uint16_t length) {
    disable_interrupts();
    // Stop any current timer
    TAC_REG = 0x00;

    // Power on sound hardware
    NR52_REG = 0x80;
    // Max volume
    NR50_REG = 0x77;
    // Enable CH3 in stereo pan (left & right)
    NR51_REG |= 0x44;

    play_bank = bank;
    play_sample_ptr = sample;
    play_length = length >> 4; // 16 bytes per interrupt block
    sample_playing = 1;

    // Set timer to 256 Hz
    if (_cpu == CGB_TYPE) {
        TMA_REG = 0x80; // In CGB double-speed mode: 32768 / 128 = 256 Hz
    } else {
        TMA_REG = 0xC0; // In DMG single-speed mode: 16384 / 64 = 256 Hz
    }
    TIMA_REG = TMA_REG;
    IF_REG &= ~TIM_IFLAG;
    TAC_REG = 0x07; // Clock 16384 Hz (or 32768 in CGB fast), Timer Enabled
    enable_interrupts();
}

uint8_t is_sample_playing(void) {
    return sample_playing;
}

void stop_sample(void) {
    disable_interrupts();
    sample_playing = 0;
    play_length = 0;
    TAC_REG = 0x00;
    NR30_REG = 0x00;
    enable_interrupts();
}
